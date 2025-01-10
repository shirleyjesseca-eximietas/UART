# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Wed Dec 11 17:40:59 2024
# Designs open: 1
#   V1: /home/shirley/CHECKOUT/DV_VLSI/UART_non_pulpino/sim/uart_11_12_24.vpd
# Toplevel windows open: 1
# 	TopLevel.1
#   Source.1: top
#   Group count = 3
#   Group DUT signal count = 45
#   Group control signal count = 86
#   Group tx_channel signal count = 18
# End_DVE_Session_Save_Info

# DVE version: W-2024.09_Full64
# DVE build date: Sep  2 2024 21:06:16


#<Session mode="Full" path="/home/shirley/CHECKOUT/DV_VLSI/UART_non_pulpino/sim/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Post
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all

# Close all windows
gui_close_window -type Console
gui_close_window -type Wave
gui_close_window -type Source
gui_close_window -type Schematic
gui_close_window -type Data
gui_close_window -type DriverLoad
gui_close_window -type List
gui_close_window -type Memory
gui_close_window -type HSPane
gui_close_window -type DLPane
gui_close_window -type Assertion
gui_close_window -type CovHier
gui_close_window -type CoverageTable
gui_close_window -type CoverageMap
gui_close_window -type CovDetail
gui_close_window -type Local
gui_close_window -type Stack
gui_close_window -type Watch
gui_close_window -type Group
gui_close_window -type Transaction



# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.1

if {![gui_exist_window -window TopLevel.1]} {
    set TopLevel.1 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.1 TopLevel.1
}
gui_show_window -window ${TopLevel.1} -show_state maximized -rect {{1 38} {1920 1168}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_hide_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 329]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 329
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 328} {height 887} {dock_state left} {dock_on_new_line true} {child_hier_colhier 230} {child_hier_coltype 100} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 429]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 429
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 886
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 428} {height 887} {dock_state left} {dock_on_new_line true} {child_data_colvariable 179} {child_data_colvalue 134} {child_data_coltype 125} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 169]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 1860
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 169
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 1919} {height 168} {dock_state bottom} {dock_on_new_line true}}
#### Start - Readjusting docked view's offset / size
set dockAreaList { top left right bottom }
foreach dockArea $dockAreaList {
  set viewList [gui_ekki_get_window_ids -active_parent -dock_area $dockArea]
  foreach view $viewList {
      if {[lsearch -exact [gui_get_window_pref_keys -window $view] dock_width] != -1} {
        set dockWidth [gui_get_window_pref_value -window $view -key dock_width]
        set dockHeight [gui_get_window_pref_value -window $view -key dock_height]
        set offset [gui_get_window_pref_value -window $view -key dock_offset]
        if { [string equal "top" $dockArea] || [string equal "bottom" $dockArea]} {
          gui_set_window_attributes -window $view -dock_offset $offset -width $dockWidth
        } else {
          gui_set_window_attributes -window $view -dock_offset $offset -height $dockHeight
        }
      }
  }
}
#### End - Readjusting docked view's offset / size
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 [gui_create_window -type {Source}  -parent ${TopLevel.1}]
gui_show_window -window ${Source.1} -show_state maximized
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings

gui_set_env TOPLEVELS::TARGET_FRAME(Source) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Schematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(PathSchematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Wave) none
gui_set_env TOPLEVELS::TARGET_FRAME(List) none
gui_set_env TOPLEVELS::TARGET_FRAME(Memory) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(DriverLoad) none
gui_update_statusbar_target_frame ${TopLevel.1}

#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {/home/shirley/CHECKOUT/DV_VLSI/UART_non_pulpino/sim/uart_11_12_24.vpd}] } {
	gui_open_db -design V1 -file /home/shirley/CHECKOUT/DV_VLSI/UART_non_pulpino/sim/uart_11_12_24.vpd -nosource
}
gui_set_precision 1ns
gui_set_time_units 1ns
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {top.DUT.control}
gui_load_child_values {top.DUT}
gui_load_child_values {top.DUT.tx_channel}


set _session_group_1 DUT
gui_sg_create "$_session_group_1"
set DUT "$_session_group_1"

gui_sg_addsignal -group "$_session_group_1" { {top.DUT.$unit} top.DUT.PCLK top.DUT.PRESETn top.DUT.PADDR top.DUT.PWDATA top.DUT.PRDATA top.DUT.PWRITE top.DUT.PENABLE top.DUT.PSEL top.DUT.PREADY top.DUT.PSLVERR top.DUT.IRQ top.DUT.TXD top.DUT.RXD top.DUT.nRTS top.DUT.nDTR top.DUT.nOUT1 top.DUT.nOUT2 top.DUT.nCTS top.DUT.nDSR top.DUT.nDCD top.DUT.nRI top.DUT.baud_o top.DUT.tx_fifo_we top.DUT.tx_enable top.DUT.tx_fifo_count top.DUT.tx_fifo_empty top.DUT.tx_fifo_full top.DUT.tx_busy top.DUT.rx_data_out top.DUT.rx_idle top.DUT.rx_overrun top.DUT.parity_error top.DUT.framing_error top.DUT.break_error top.DUT.rx_fifo_count top.DUT.rx_fifo_empty top.DUT.push_rx_fifo top.DUT.rx_enable top.DUT.rx_fifo_re top.DUT.loopback top.DUT.LCR top.DUT.rx_fifo_full top.DUT.TXDout top.DUT.RXDin }

set _session_group_2 control
gui_sg_create "$_session_group_2"
set control "$_session_group_2"

gui_sg_addsignal -group "$_session_group_2" { {top.DUT.control.$unit} top.DUT.control.PCLK top.DUT.control.PRESETn top.DUT.control.PSEL top.DUT.control.PWRITE top.DUT.control.PENABLE top.DUT.control.PADDR top.DUT.control.PWDATA top.DUT.control.PRDATA top.DUT.control.PREADY top.DUT.control.PSLVERR top.DUT.control.LCR top.DUT.control.tx_fifo_we top.DUT.control.tx_enable top.DUT.control.tx_fifo_count top.DUT.control.tx_fifo_empty top.DUT.control.tx_fifo_full top.DUT.control.tx_busy top.DUT.control.rx_data_out top.DUT.control.rx_idle top.DUT.control.rx_overrun top.DUT.control.parity_error top.DUT.control.framing_error top.DUT.control.break_error top.DUT.control.rx_fifo_count top.DUT.control.rx_fifo_empty top.DUT.control.rx_fifo_full top.DUT.control.push_rx_fifo top.DUT.control.rx_enable top.DUT.control.rx_fifo_re top.DUT.control.loopback top.DUT.control.ctsn top.DUT.control.dsrn top.DUT.control.dcdn top.DUT.control.rin top.DUT.control.rtsn top.DUT.control.dtrn top.DUT.control.out1n top.DUT.control.out2n top.DUT.control.irq top.DUT.control.baud_o top.DUT.control.tx_state top.DUT.control.rx_state top.DUT.control.we top.DUT.control.re top.DUT.control.rx_fifo_over_threshold top.DUT.control.IER top.DUT.control.IIR top.DUT.control.FCR top.DUT.control.MCR top.DUT.control.MSR top.DUT.control.LSR top.DUT.control.DIVISOR top.DUT.control.dlc top.DUT.control.enable top.DUT.control.start_dlc top.DUT.control.rx_enabled top.DUT.control.tx_enabled top.DUT.control.rx_overrun_int top.DUT.control.reset_overrun top.DUT.control.tx_int top.DUT.control.rx_int top.DUT.control.rx_parity_int top.DUT.control.rx_framing_int top.DUT.control.rx_break_int top.DUT.control.cts_0 top.DUT.control.cts_1 top.DUT.control.cts_int top.DUT.control.dcd_0 top.DUT.control.dcd_1 top.DUT.control.dcd_int top.DUT.control.dsr_0 top.DUT.control.dsr_1 top.DUT.control.dsr_int top.DUT.control.ri_0 top.DUT.control.ri_1 top.DUT.control.ri_int top.DUT.control.ms_int top.DUT.control.nDCD_1 top.DUT.control.nCTS_1 top.DUT.control.nDSR_1 top.DUT.control.nRI_1 top.DUT.control.ls_int top.DUT.control.fifo_error top.DUT.control.last_tx_fifo_empty top.DUT.control.fsm_state }

set _session_group_3 tx_channel
gui_sg_create "$_session_group_3"
set tx_channel "$_session_group_3"

gui_sg_addsignal -group "$_session_group_3" { top.DUT.tx_channel.TX_BUSY_CHK {top.DUT.tx_channel.$unit} top.DUT.tx_channel.busy top.DUT.tx_channel.tx_state top.DUT.tx_channel.PCLK top.DUT.tx_channel.PRESETn top.DUT.tx_channel.PWDATA top.DUT.tx_channel.tx_fifo_push top.DUT.tx_channel.LCR top.DUT.tx_channel.enable top.DUT.tx_channel.tx_fifo_empty top.DUT.tx_channel.tx_fifo_full top.DUT.tx_channel.tx_fifo_count top.DUT.tx_channel.TXD top.DUT.tx_channel.bit_counter top.DUT.tx_channel.tx_buffer top.DUT.tx_channel.tx_fifo_out top.DUT.tx_channel.pop_tx_fifo }

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 870



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*}
gui_hier_list_init -id ${Hier.1}
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} top}
catch {gui_list_select -id ${Hier.1} {top.DUT}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {top.DUT.tx_channel}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active top /home/shirley/CHECKOUT/DV_VLSI/UART_non_pulpino//verif/env/top.sv
gui_view_scroll -id ${Source.1} -vertical -set 15
gui_src_set_reusable -id ${Source.1}
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${Source.1}
	gui_set_active_window -window ${HSPane.1}
}
#</Session>

