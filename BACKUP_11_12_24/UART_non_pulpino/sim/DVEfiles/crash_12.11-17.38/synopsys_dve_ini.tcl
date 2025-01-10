gui_state_default_create -off -ini

# Globals
gui_set_state_value -category Globals -key recent_databases -value {{gui_open_db -file uart_11_12_24.vpd} {gui_open_db -file uart_new.vpd} {gui_open_db -file uart_new.vpd -design V1} {gui_open_db -file /home/shirley/work_space/DV_VLSI/UART_non_pulpino/sim/uart_new.vpd -design V2} {gui_open_db -file uart.vpd}}
gui_set_state_value -category Globals -key recent_sessions -value {{gui_load_session -ignore_errors -file /home/shirley/work_space/DV_VLSI/UART_non_pulpino/sim/apb_signals.vpd.tcl -ignore_errors} {gui_load_session -ignore_errors -file /home/shirley/work_space/DV_VLSI/UART_non_pulpino/sim/apb_signals.vpd.tcl}}

# Layout
gui_set_state_value -category Layout -key child_console_size_x -value 1919
gui_set_state_value -category Layout -key child_console_size_y -value 169
gui_set_state_value -category Layout -key child_data_coltype -value 125
gui_set_state_value -category Layout -key child_data_colvalue -value 134
gui_set_state_value -category Layout -key child_data_colvariable -value 179
gui_set_state_value -category Layout -key child_data_size_x -value 429
gui_set_state_value -category Layout -key child_data_size_y -value 886
gui_set_state_value -category Layout -key child_driver_size_x -value 446
gui_set_state_value -category Layout -key child_driver_size_y -value 179
gui_set_state_value -category Layout -key child_hier_col3 -value {-1}
gui_set_state_value -category Layout -key child_hier_colhier -value 230
gui_set_state_value -category Layout -key child_hier_colpd -value 0
gui_set_state_value -category Layout -key child_hier_size_x -value 329
gui_set_state_value -category Layout -key child_hier_size_y -value 886
gui_set_state_value -category Layout -key child_list_down -value 203
gui_set_state_value -category Layout -key child_list_right -value 444
gui_set_state_value -category Layout -key child_source_docknewline -value false
gui_set_state_value -category Layout -key child_source_pos_x -value {-2}
gui_set_state_value -category Layout -key child_source_pos_y -value {-15}
gui_set_state_value -category Layout -key child_source_size_x -value 1164
gui_set_state_value -category Layout -key child_source_size_y -value 881
gui_set_state_value -category Layout -key child_wave_colname -value 276
gui_set_state_value -category Layout -key child_wave_colvalue -value 276
gui_set_state_value -category Layout -key child_wave_left -value 557
gui_set_state_value -category Layout -key child_wave_right -value 1357
gui_set_state_value -category Layout -key main_pos_x -value 1
gui_set_state_value -category Layout -key main_pos_y -value 38
gui_set_state_value -category Layout -key main_size_x -value 1920
gui_set_state_value -category Layout -key main_size_y -value 1168
gui_set_state_value -category Layout -key stand_list_child_docknewline -value false
gui_set_state_value -category Layout -key stand_list_child_pos_x -value {-2}
gui_set_state_value -category Layout -key stand_list_child_pos_y -value {-15}
gui_set_state_value -category Layout -key stand_list_child_size_x -value 604
gui_set_state_value -category Layout -key stand_list_child_size_y -value 348
gui_set_state_value -category Layout -key stand_list_top_pos_y -value 69
gui_set_state_value -category Layout -key stand_list_top_size_x -value 1099
gui_set_state_value -category Layout -key stand_list_top_size_y -value 568
gui_set_state_value -category Layout -key stand_wave_child_docknewline -value false
gui_set_state_value -category Layout -key stand_wave_child_pos_x -value {-2}
gui_set_state_value -category Layout -key stand_wave_child_pos_y -value {-15}
gui_set_state_value -category Layout -key stand_wave_child_size_x -value 1924
gui_set_state_value -category Layout -key stand_wave_child_size_y -value 1050
gui_set_state_value -category Layout -key stand_wave_top_pos_x -value 1
gui_set_state_value -category Layout -key stand_wave_top_pos_y -value 38
gui_set_state_value -category Layout -key stand_wave_top_size_x -value 1920
gui_set_state_value -category Layout -key stand_wave_top_size_y -value 1168

# list_value_column

# Sim

# Assertion

# Stream

# Data

# TBGUI

# Driver

# Class

# Member

# ObjectBrowser

# UVM

# Local

# Backtrace

# FastSearch

# Exclusion

# SaveSession

# FindDialog
gui_create_state_key -category FindDialog -key m_pMatchCase -value_type bool -value false
gui_create_state_key -category FindDialog -key m_pMatchWord -value_type bool -value false
gui_create_state_key -category FindDialog -key m_pUseCombo -value_type string -value {}
gui_create_state_key -category FindDialog -key m_pWrapAround -value_type bool -value true

# SearchDialog
gui_create_state_key -category SearchDialog -key MatchCase -value_type bool -value false
gui_create_state_key -category SearchDialog -key MatchWord -value_type bool -value true
gui_create_state_key -category SearchDialog -key SearchMode -value_type string -value Wildcards
gui_create_state_key -category SearchDialog -key UseCombo -value_type bool -value true

# Widget_History
gui_create_state_key -category Widget_History -key Find|m_pFindFrame|m_pFindCombo -value_type string -value {dlc PADDR}
gui_create_state_key -category Widget_History -key Search.1|m_pStringCombo -value_type string -value fsm_state
gui_create_state_key -category Widget_History -key TopLevel.1|qt_left_dock|DockWnd2|DLPane.1|pages|Data.1|hbox|textfilter -value_type string -value {fsm_state {}}
gui_create_state_key -category Widget_History -key TopLevel.1|qt_top_dock|&Edit|FindCombo -value_type string -value {dlc PADDR}
gui_create_state_key -category Widget_History -key TopLevel.2|qt_top_dock|&Edit|FindCombo -value_type string -value {dlc PADDR}


gui_state_default_create -off
