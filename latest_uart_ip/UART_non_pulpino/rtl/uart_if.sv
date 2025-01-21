interface uart_if (input bit clock);

  // APB Signals
  logic PRESETn;		   // Reset signal
  logic [31:0] PADDR;              // Address bus
  logic [31:0] PWDATA;             // Write data bus
  logic [31:0] PRDATA;             // Read data bus
  logic PWRITE;                    // Write enable
  logic PENABLE;                   // Transfer enable
  logic PSEL;                      // Slave select
  logic PREADY;                    // Ready signal
  logic PSLVERR;                   // Error signal

  // UART Interrupt Request
  logic IRQ;                       // Interrupt request

  // UART Serial Signals
  logic TXD;                       // Transmit data
  logic RXD;                       // Receive data

  logic LCR;

  logic tx_fifo_empty;
  logic tx_fifo_full;
  logic tx_fifo_count;

  // UART Modem Control Signals
  logic nRTS;                      // Request to send
  logic nDTR;                      // Data terminal ready
  logic nOUT1;                     // Modem control line 1
  logic nOUT2;                     // Modem control line 2
  logic nCTS;                      // Clear to send
  logic nDSR;                      // Data set ready
  logic nDCD;                      // Data carrier detect
  logic nRI;                       // Ring indicator

  // Baud Rate Generator Output
  logic baud_o;                    // Baud rate clock

  // Transmitter Driver Clocking Block
  clocking tx_drv_cb @(posedge clock);
    default input #1 output #0;
    // APB signals
    output PADDR;                  // Address bus
    output PWDATA;                 // Write data
    output PWRITE;                 // Write enable
    output PENABLE;                // Transfer enable
    output PSEL;                   // Slave select
    // UART transmitter-specific signals
    output TXD;                    // Transmit data
    input nCTS;                    // Clear to send signal
    input nDSR;                    // Data set ready
    input nDCD;                    // Data carrier detect
    input PREADY;                  // Ready signal
    input PSLVERR;                 // Error signal
  endclocking

  // Transmitter Monitor Clocking Block
  clocking tx_mon_cb @(posedge clock);
    default input #1 output #0;
    // APB signals
    input PADDR;                   // Address bus
    input PWDATA;                  // Write data
    input PWRITE;                  // Write enable
    input PENABLE;                 // Transfer enable
    input PSEL;                    // Slave select
    // UART transmitter-specific signals
    input TXD;                     // Transmit data
    input PREADY;                  // Ready signal
    input PSLVERR;                 // Error signal
  endclocking

  // Receiver Driver Clocking Block
  clocking rx_drv_cb @(posedge clock);
    default input #1 output #0;
    // APB signals
    output PADDR;                  // Address bus
    output PWDATA;                 // Write data
    output PWRITE;                 // Write enable
    output PENABLE;                // Transfer enable
    output PSEL;                   // Slave select
    // UART receiver-specific signals
    output nRTS;                   // Request to send
    output nDTR;                   // Data terminal ready
    output nOUT1;                  // Modem control line 1
    output nOUT2;                  // Modem control line 2
    input RXD;                     // Receive data
    input PREADY;                  // Ready signal
    input PSLVERR;                 // Error signal
    output IRQ;                    // Interrupt request
  endclocking

  // Receiver Monitor Clocking Block
  clocking rx_mon_cb @(posedge clock);
    default input #1 output #0;
    // APB signals
    input PADDR;                   // Address bus
    input PWDATA;                  // Write data
    input PWRITE;                  // Write enable
    input PENABLE;                 // Transfer enable
    input PSEL;                    // Slave select
    // UART receiver-specific signals
    input RXD;                     // Receive data
    input nRTS;                    // Request to send
    input nDTR;                    // Data terminal ready
    input nOUT1;                   // Modem control line 1
    input nOUT2;                   // Modem control line 2
    input IRQ;                     // Interrupt request
    input PREADY;                  // Ready signal
    input PSLVERR;                 // Error signal
  endclocking

endinterface
