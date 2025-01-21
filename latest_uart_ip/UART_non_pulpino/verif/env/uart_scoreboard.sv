class uart_tx_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(uart_tx_scoreboard)

  // Analysis FIFOs for receiving transactions
  uvm_tlm_analysis_fifo #(uart_tx_xtn) apb_fifo;
  uvm_tlm_analysis_fifo #(uart_tx_xtn) tx_fifo;

  //uvm_tlm_analysis_fifo #(uart_rx_xtn) rx_apb_fifo;
  uvm_tlm_analysis_fifo #(uart_rx_xtn) rx_fifo;


  // For coverage
  uart_tx_xtn tx_cov_data;
  uart_rx_xtn rx_cov_data;


  // Constructor
  function new(string name = "uart_tx_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase to initialize FIFOs
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    apb_fifo = new("apb_fifo", this);
    tx_fifo = new("tx_fifo", this);
    //rx_apb_fifo = new("rx_apb_fifo", this);
    rx_fifo = new("rx_fifo", this);

  endfunction

  // Run phase to compare transactions

    virtual task run_phase(uvm_phase phase);
      fork
        apb_config();
        tx_trans();
      join_none
//       fork
//         apb_config_rx();
//         rx_trans();
//       join_none
    endtask

  int temp_databit;
  bit temp_parity_bit;
  bit[7:0]div_low, div_high, data_0_tx, data_0_rx;
  int clk_cycles_per_bit;
  int no_of_cycles;


  ///////////////////               APB Transaction                ///////////////////

  task apb_config();

    uart_tx_xtn apb_xtn;
    bit [1:0] wordlength;
    bit parity_bit, stop_bit;
    bit [7:0] temp_reg, parity_temp;
    int data_bit, i;

    forever begin
      // Get a transaction from the APB FIFO
      apb_fifo.get(apb_xtn);
      tx_cov_data = apb_xtn;

      // Step 1: Check if address matches the LCR (Line Control Register)
      //$display("SB : PADDR = %0h", apb_xtn.PADDR);
      if (apb_xtn.PADDR == 'hC) begin
        wordlength = apb_xtn.PWDATA[1:0];   // Word length (e.g., 5, 6, 7, or 8 bits)
        stop_bit = apb_xtn.PWDATA[2];       // Stop bit
        parity_bit = apb_xtn.PWDATA[3];     // Parity bit

        case (wordlength)
          2'b00: data_bit = 5;
          2'b01: data_bit = 6;
          2'b10: data_bit = 7;
          2'b11: data_bit = 8;
          default: data_bit = 8;
        endcase

        temp_databit = data_bit;
        temp_parity_bit = parity_bit;


        `uvm_info("UART_SCB", $sformatf("LCR Configured: Wordlength=%0d, Stop Bit=%0b, Parity Bit=%0b", data_bit, stop_bit, parity_bit), UVM_MEDIUM);
      end


      if (apb_xtn.PADDR == 'h1C) begin
        div_low = apb_xtn.PWDATA[7:0];
        `uvm_info("DIV_LOW", $sformatf("DIV_LOW: =%0d", div_low ), UVM_LOW);
      end

      if (apb_xtn.PADDR == 'h20) begin
        div_high = apb_xtn.PWDATA[7:0];
        `uvm_info("DIV_HIGH", $sformatf("DIV_HIGH: =%0d", div_high ), UVM_LOW);
      end

      if (apb_xtn.PADDR == 'h0) begin
        data_0_tx = apb_xtn.PWDATA[7:0];
        `uvm_info("DATA_0_TX", $sformatf("DATA_0_TX: =%0h", data_0_tx ), UVM_LOW);
      end

    end
   endtask : apb_config

  ///////////////////               UART TX Transaction                ///////////////////

  task tx_trans();

        bit [7:0] temp_reg, parity_temp;
        uart_tx_xtn tx_xtn;

      // Step 2: Detect TXD going low (start bit detection) using IF statement
      forever begin

        clk_cycles_per_bit = {div_high, div_low} + 1'b1;
        //$display(" clk_cycles_per_bit = %0d ", clk_cycles_per_bit);

        if(temp_databit != 0) begin
          no_of_cycles = (clk_cycles_per_bit * temp_databit) + (4 * clk_cycles_per_bit) + 1'b1;    //.. 3 -> 4
        end

       tx_fifo.get(tx_xtn);

       if(tx_xtn.TXD == 0) begin
        `uvm_info("UART_SCB", "Start bit detected", UVM_LOW);

        repeat(clk_cycles_per_bit) tx_fifo.get(tx_xtn);


         for (int i = 0; i < temp_databit; i++) begin         // Transmit wordlength bits and store TXD in a temp register
           repeat(no_of_cycles/2) tx_fifo.get(tx_xtn);//..
           $display("NO OF CYCLES = %0d", no_of_cycles);

          temp_reg[i] = tx_xtn.TXD;
           `uvm_info("UART_SCB", $sformatf("Data Bit[%0d]: TXD=%0b", i, tx_xtn.TXD), UVM_LOW);
           repeat(clk_cycles_per_bit/2) tx_fifo.get(tx_xtn);

        end

        if (temp_parity_bit) begin                       // Handle parity bit if enabled
          repeat(no_of_cycles/2) tx_fifo.get(tx_xtn); // tx_fifo.get(tx_xtn);
          parity_temp = tx_xtn.TXD;
          `uvm_info("UART_SCB", $sformatf("Parity Bit: TXD=%0b", tx_xtn.TXD), UVM_LOW);
          repeat(no_of_cycles/5) tx_fifo.get(tx_xtn);
            repeat(clk_cycles_per_bit) tx_fifo.get(tx_xtn);
          `uvm_info("UART_SCB", "Delay after capturing parity", UVM_LOW);
        end
          else
            repeat(no_of_cycles) tx_fifo.get(tx_xtn);

         //repeat(clk_cycles_per_bit*2) tx_fifo.get(tx_xtn);   //added
        //tx_fifo.get(tx_xtn);                       // Handle stop bit
         //repeat(no_of_cycles/2) tx_fifo.get(tx_xtn);
        if (tx_xtn.TXD !== 1) begin
          `uvm_error("UART_SCB", $sformatf("Stop Bit Mismatch: TXD=%0b", tx_xtn.TXD));
        end else begin
          `uvm_info("UART_SCB", $sformatf("Stop Bit Matched: TXD=%0b", tx_xtn.TXD), UVM_LOW);
              if(temp_reg !== data_0_tx) begin
                  `uvm_error("UART_SCB", $sformatf("---------------------   TXD DATA MISMATCH: temp_reg=%0h, data_0_tx=%0h   -----------------------", temp_reg, data_0_tx));
            end else begin
                  `uvm_info("UART_SCB", $sformatf("----------------------   TXD DATA MATCH: temp_reg=%0h, data_0_tx=%0h   ------------------------", temp_reg, data_0_tx), UVM_LOW);
                data_0_tx = 0;  //added
            end
        end



      end
     end
  endtask : tx_trans

  ///////////////////               APB_RX Transaction                ///////////////////

  task apb_config_rx();

    uart_rx_xtn rx_apb_xtn;
    bit [1:0] wordlength;
    bit parity_bit, stop_bit;
    bit [7:0] temp_reg, parity_temp;
    int data_bit, i;

    forever begin
      // Get a transaction from the APB FIFO
      rx_fifo.get(rx_apb_xtn);
      rx_cov_data = rx_apb_xtn;

      // Step 1: Check if address matches the LCR (Line Control Register)
      //$display("SB_RX : PADDR = %0h", apb_xtn.PADDR);
      if (rx_apb_xtn.PADDR == 'hC) begin
        wordlength = rx_apb_xtn.PWDATA[1:0];   // Word length (e.g., 5, 6, 7, or 8 bits)
        stop_bit = rx_apb_xtn.PWDATA[2];       // Stop bit - uncommented
        parity_bit = rx_apb_xtn.PWDATA[3];     // Parity bit

        case (wordlength)
          2'b00: data_bit = 5;
          2'b01: data_bit = 6;
          2'b10: data_bit = 7;
          2'b11: data_bit = 8;
          default: data_bit = 8;
        endcase

        temp_databit = data_bit;
        temp_parity_bit = parity_bit;


        `uvm_info("UART_SCB_RX", $sformatf("LCR Configured: Wordlength=%0d, Stop Bit=%0b, Parity Bit=%0b", data_bit, stop_bit, parity_bit), UVM_MEDIUM);
      end


      if (rx_apb_xtn.PADDR == 'h1C) begin
        div_low = rx_apb_xtn.PWDATA[7:0];
        `uvm_info("DIV_LOW", $sformatf("DIV_LOW: =%0d", div_low ), UVM_LOW);
      end

      if (rx_apb_xtn.PADDR == 'h20) begin
        div_high = rx_apb_xtn.PWDATA[7:0];
        `uvm_info("DIV_HIGH", $sformatf("DIV_HIGH: =%0d", div_high ), UVM_LOW);
      end

      if(rx_apb_xtn.PRDATA[7:0] !== 1'b0) begin
        if (rx_apb_xtn.PADDR == 'h0) begin
          data_0_rx = rx_apb_xtn.PRDATA[7:0];
        //$display("PR_DATA = %0h", rx_apb_xtn.PRDATA[7:0]);
        //`uvm_info("DATA_0_RX", $sformatf("DATA_0_RX: =%0d, PRDATA = %0h", data_0_rx, rx_apb_xtn.PRDATA ), UVM_LOW);
      end
    end


    end
   endtask : apb_config_rx

  task rx_trans();

        bit [7:0] temp_reg, parity_temp;
        uart_rx_xtn rx_xtn;

      // Step 2: Detect RXD going low (start bit detection) using IF statement
      forever begin

        clk_cycles_per_bit = {div_high, div_low} + 1'b1;
        //$display("SB : clk cycles per bit = %0h", clk_cycles_per_bit);

        if(temp_databit != 0) begin
          no_of_cycles = (clk_cycles_per_bit * temp_databit) + (4 * clk_cycles_per_bit) + 1'b1;    //.. 3 -> 4
        end

        repeat(clk_cycles_per_bit*2) rx_fifo.get(rx_xtn);
        rx_fifo.get(rx_xtn); //changed

        //$display("RXD_1 = %0d", rx_xtn.RXD);

       if(rx_xtn.RXD == 0) begin
        `uvm_info("UART_SCB_RX", "Start bit detected", UVM_LOW);

         repeat(clk_cycles_per_bit*7) rx_fifo.get(rx_xtn); //changed
         repeat(clk_cycles_per_bit/2) rx_fifo.get(rx_xtn);

         for (int i = 0; i < temp_databit; i++) begin         // Transmit wordlength bits and store RXD in a temp register
           repeat(no_of_cycles/2) rx_fifo.get(rx_xtn);  //changing
           //$display("NO OF CYCLES = %0d", no_of_cycles);

           temp_reg[i] = rx_xtn.RXD;
           `uvm_info("UART_SCB_RX", $sformatf("Data Bit[%0d]: RXD=%0b", i, rx_xtn.RXD), UVM_LOW);
           repeat(clk_cycles_per_bit) rx_fifo.get(rx_xtn);
        end

        if (temp_parity_bit) begin                       // Handle parity bit if enabled
          repeat(no_of_cycles) rx_fifo.get(rx_xtn);
          //rx_fifo.get(rx_xtn);
          parity_temp = rx_xtn.RXD;
          `uvm_info("UART_SCB_RX", $sformatf("Parity Bit: RXD=%0b", rx_xtn.RXD), UVM_LOW);
          rx_fifo.get(rx_xtn);
          repeat(clk_cycles_per_bit) rx_fifo.get(rx_xtn);
        end
        else
          repeat(no_of_cycles) rx_fifo.get(rx_xtn);


         rx_fifo.get(rx_xtn);                       // ..
         if (rx_xtn.RXD !== 1) begin
           `uvm_error("UART_SCB_RX", $sformatf("Stop Bit Mismatch: RXD=%0b", rx_xtn.RXD));
         end else begin
           `uvm_info("UART_SCB_RX", $sformatf("Stop Bit Matched: RXD=%0b", rx_xtn.RXD), UVM_LOW);

           wait(data_0_rx !== 1'b0)
             if(temp_reg !== data_0_rx) begin
             //$display("data_0_rx = %0h", data_0_rx);
             `uvm_error("UART_SCB_RX", $sformatf("--------------------   RXD Data Mismatch: temp_reg=%0h, data_0_rx=%0h   ----------------------", temp_reg, data_0_rx));
           end else begin
             `uvm_info("UART_SCB_RX", $sformatf("--------------------   RXD Data Matched: temp_reg=%0h, data_0_rx=%0h   ---------------------", temp_reg, data_0_rx), UVM_LOW);
           end
           data_0_rx = 1'b0;

        end


      end
     end
  endtask : rx_trans


endclass
