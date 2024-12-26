verdiWindowResize -win $_vdCoverage_1 "0" "32" "1920" "1011"
gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
verdiSetFont  -font  {DejaVu Sans}  -size  11
verdiSetFont -font "DejaVu Sans" -size "11"
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
gui_open_cov  -hier merged_dir.vdb -testdir {} -test {merged_dir/merged} -merge MergedTest -db_max_tests 10 -sdc_level 1 -fsm transition
verdiSetActWin -dock widgetDock_<CovDetail>
verdiWindowResize -win $_vdCoverage_1 "0" "32" "1920" "1011"
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} top
verdiSetActWin -dock widgetDock_<Summary>
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} top.DUT
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.control   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.control  top.DUT.rx_channel   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.rx_channel  top.DUT.tx_channel   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.tx_channel   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT  top.DUT.control   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.control  top.DUT.rx_channel   }
gui_exclusion_file -load -file { /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/exclusion_file.el }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.rx_channel  top.DUT.control   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.control  top.DUT.rx_channel   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.rx_channel  top.DUT.tx_channel   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.tx_channel   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top   }
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_sort -id  CovDetail.1   -list {line} {Coverage}
gui_list_sort -id  CovDetail.1   -list {line} {Category}
gui_list_sort -id  CovDetail.1   -list {line} {Coverage}
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top  top.DUT   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
gui_src_highlight_item -id CovSrc.1 -lfrom 34 -idxfrom 15 -fileIdFrom 0 -lto 34 -idxto 21 -fileIdTo 0 -selection {PWDATA} -selectionId 0 -replace 0
gui_cov_src_double_click -id CovSrc.1 -line 34 -col 19 -insert 0 -file /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/../rtl/design.sv
gui_src_highlight_item -id CovSrc.1 -lfrom 34 -idxfrom 15 -fileIdFrom 0 -lto 34 -idxto 21 -fileIdTo 0 -selection {PWDATA} -selectionId 0 -replace 0
verdiSetActWin -dock widgetDock_<CovSrc.1>
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
gui_cov_src_double_click -id CovSrc.1 -line 35 -col 17 -insert 0 -file /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/../rtl/design.sv
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
gui_summarybar_goto -id  CovSrc.1   86
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT  top   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_covdetail_select -id  CovDetail.1   -name   Toggle
verdiSetActWin -dock widgetDock_<CovDetail>
gui_covdetail_select -id  CovDetail.1   -name   FSM
gui_covdetail_select -id  CovDetail.1   -name   Condition
gui_covdetail_select -id  CovDetail.1   -name   Branch
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top  top.DUT   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
gui_cov_src_double_click -id CovSrc.1 -line 35 -col 18 -insert 0 -file /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/../rtl/design.sv
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
verdiSetActWin -dock widgetDock_<CovSrc.1>
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
gui_cov_src_double_click -id CovSrc.1 -line 35 -col 18 -insert 0 -file /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/../rtl/design.sv
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
gui_list_expand -id  CovDetail.1   -list {branch} Item0
verdiSetActWin -dock widgetDock_<CovDetail>
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
verdiSetActWin -dock widgetDock_<CovSrc.1>
gui_search_widget 
gui_cov_src_double_click -id CovSrc.1 -line 35 -col 18 -insert 0 -file /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/../rtl/design.sv
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
gui_cov_src_double_click -id CovSrc.1 -line 35 -col 18 -insert 0 -file /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/../rtl/design.sv
gui_src_highlight_item -id CovSrc.1 -lfrom 35 -idxfrom 15 -fileIdFrom 0 -lto 35 -idxto 21 -fileIdTo 0 -selection {PRDATA} -selectionId 0 -replace 0
gui_src_cov_navigation_set_criteria -id CovSrc.1 -category Excluded
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
verdiSetActWin -dock widgetDock_<CovSrc.1>
gui_src_highlight_item -id CovSrc.1 -lfrom 164 -idxfrom 7 -fileIdFrom 0 -lto 164 -idxto 12 -fileIdTo 0 -selection {RXDin} -selectionId 0 -replace 0
gui_cov_src_double_click -id CovSrc.1 -line 164 -col 10 -insert 0 -file /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/../rtl/design.sv
gui_src_highlight_item -id CovSrc.1 -lfrom 164 -idxfrom 7 -fileIdFrom 0 -lto 164 -idxto 12 -fileIdTo 0 -selection {RXDin} -selectionId 0 -replace 0
gui_cov_src_double_click -id CovSrc.1 -line 164 -col 36 -insert 0 -file /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/../rtl/design.sv
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT  top.DUT.control   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT.control  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list branch { Item15   }
gui_list_action -id  CovDetail.1 -list {branch} Item15  -column {Name} 
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.control  top.DUT   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CovDetail.1 -list branch { Item0   }
gui_list_action -id  CovDetail.1 -list {branch} Item0  -column {Name} 
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_expand -id  CovDetail.1   -list {branch} Item0
gui_covdetail_select -id  CovDetail.1   -name   Condition
gui_covdetail_select -id  CovDetail.1   -name   FSM
gui_covdetail_select -id  CovDetail.1   -name   Toggle
gui_list_select -id CovDetail.1 -list tgl { {PRDATA[31:0]}   }
gui_list_action -id  CovDetail.1 -list {tgl} {PRDATA[31:0]}
gui_exclude_items  -id CovDetail.1  -list tglDetail {PRDATA[31:8]}  -tgl_transition 0to1
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31:8]}   }
gui_exclude_items  -id CovDetail.1  -list tglDetail {PRDATA[31:8]}  -tgl_transition 0to1  -include
gui_list_action -id  CovDetail.1 -list {tglDetail} {PRDATA[31]}
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[30]}  {PRDATA[29]}  {PRDATA[28]}  {PRDATA[27]}  {PRDATA[26]}  {PRDATA[25]}  {PRDATA[24]}  {PRDATA[23]}  {PRDATA[22]}  {PRDATA[21]}  {PRDATA[20]}  {PRDATA[19]}  {PRDATA[18]}  {PRDATA[17]}  {PRDATA[16]}  {PRDATA[15]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}  {PRDATA[8]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31]}  {PRDATA[30]}  {PRDATA[29]}  {PRDATA[28]}  {PRDATA[27]}  {PRDATA[26]}  {PRDATA[25]}  {PRDATA[24]}  {PRDATA[23]}  {PRDATA[22]}  {PRDATA[21]}  {PRDATA[20]}  {PRDATA[19]}  {PRDATA[18]}  {PRDATA[17]}  {PRDATA[16]}  {PRDATA[15]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[8]}  {PRDATA[7:0]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[7:0]}  {PRDATA[8]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31]}  {PRDATA[30]}  {PRDATA[29]}  {PRDATA[28]}  {PRDATA[27]}  {PRDATA[26]}  {PRDATA[25]}  {PRDATA[24]}  {PRDATA[23]}  {PRDATA[22]}  {PRDATA[21]}  {PRDATA[20]}  {PRDATA[19]}  {PRDATA[18]}  {PRDATA[17]}  {PRDATA[16]}  {PRDATA[15]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected  -include
gui_exclude_items  -id CovDetail.1  -list tglDetail {PRDATA[15]}  -tgl_transition 0to1
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31]}  {PRDATA[30]}  {PRDATA[29]}  {PRDATA[28]}  {PRDATA[27]}  {PRDATA[26]}  {PRDATA[25]}  {PRDATA[24]}  {PRDATA[23]}  {PRDATA[22]}  {PRDATA[21]}  {PRDATA[20]}  {PRDATA[19]}  {PRDATA[18]}  {PRDATA[17]}  {PRDATA[16]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}  {PRDATA[8]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[15]}  {PRDATA[18]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[17]}  {PRDATA[16]}  {PRDATA[15]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}  {PRDATA[8]}   }
gui_annotation_dlg -opt add
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[18]}  {PRDATA[17]}  {PRDATA[16]}  {PRDATA[15]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}  {PRDATA[8]}  {PRDATA[31]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[30]}  {PRDATA[29]}  {PRDATA[28]}  {PRDATA[27]}  {PRDATA[26]}  {PRDATA[25]}  {PRDATA[24]}  {PRDATA[23]}  {PRDATA[22]}  {PRDATA[21]}  {PRDATA[20]}  {PRDATA[19]}  {PRDATA[18]}  {PRDATA[17]}  {PRDATA[16]}  {PRDATA[15]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}  {PRDATA[8]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected  -include  -tgl_transition  0to1
verdiDockWidgetSetCurTab -dock widgetDock_<HvpDetail>
verdiSetActWin -dock widgetDock_<HvpDetail>
verdiDockWidgetSetCurTab -dock widgetDock_<CovDetail>
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_action -id  CovDetail.1 -list {tgl} {PRDATA[31:0]}
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31]}  {PRDATA[30]}  {PRDATA[29]}  {PRDATA[28]}  {PRDATA[27]}  {PRDATA[26]}  {PRDATA[25]}  {PRDATA[24]}  {PRDATA[23]}  {PRDATA[22]}  {PRDATA[21]}  {PRDATA[20]}  {PRDATA[19]}  {PRDATA[18]}  {PRDATA[17]}  {PRDATA[16]}  {PRDATA[15]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[8]}  {PRDATA[9]}   }
gui_exclude_items  -id CovDetail.1  -list tglDetail {PRDATA[7:0]}  -tgl_transition 0to1
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[9]}  {PRDATA[7:0]}   }
verdiSetActWin -dock widgetDock_<HvpDetail>
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
gui_summarybar_goto -id  CovSrc.1   160
verdiSetActWin -dock widgetDock_<CovSrc.1>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT  top   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
verdiSetActWin -dock widgetDock_<CovSrc.1>
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiSetActWin -dock widgetDock_<CovDetail>
gui_covdetail_select -id  CovDetail.1   -name   Condition
gui_list_sort -id  CovDetail.1   -list {cond} -descending  {Expression}
gui_list_sort -id  CovDetail.1   -list {cond} {Expression}
gui_covdetail_select -id  CovDetail.1   -name   Branch
gui_covdetail_select -id  CovDetail.1   -name   Assert
gui_covdetail_select -id  CovDetail.1   -name   FSM
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top  top.DUT   }
verdiSetActWin -dock widgetDock_<Summary>
gui_covdetail_select -id  CovDetail.1   -name   Toggle
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CovDetail.1 -list tgl { {PADDR[31:0]}   }
verdiSetActWin -dock widgetDock_<CovDetail>
gui_exclude_items  -id CovDetail.1  -list tglDetail {PADDR[31:6]}  -tgl_transition 0to1
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}  {PADDR[1:0]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[1:0]}  {PADDR[31:6]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[1:0]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected  -include
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}  {PADDR[1:0]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[1:0]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected  -include  -tgl_transition  0to1
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}  {PADDR[1:0]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[1:0]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}  {PADDR[1:0]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[1:0]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected  -include
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}  {PADDR[1:0]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[5:2]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[5:2]}  {PADDR[31:6]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[1:0]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected
gui_list_select -id CovDetail.1 -list tglDetail { {PADDR[31:6]}  {PADDR[1:0]}   }
gui_search_widget 
gui_list_select -id CovDetail.1 -list tgl { {PADDR[31:0]}  {LCR[7:0]}   }
gui_list_action -id  CovDetail.1 -list {tgl} {LCR[7:0]}
gui_list_select -id CovDetail.1 -list tglDetail { {LCR[3:0]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {LCR[3:0]}  {LCR[7:4]}   }
gui_list_select -id CovDetail.1 -list tgl { {LCR[7:0]}  {PADDR[31:0]}   }
gui_list_select -id CovDetail.1 -list tgl { {PADDR[31:0]}  PENABLE   }
gui_list_select -id CovDetail.1 -list tgl { PENABLE  {PRDATA[31:0]}   }
gui_list_action -id  CovDetail.1 -list {tgl} {PRDATA[31:0]}
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[7:0]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail } { {PRDATA[7:0]} }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[7:0]}  {PRDATA[31:8]}   }
gui_list_action -id  CovDetail.1 -list {tglDetail} {PRDATA[31]}
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31]}  {PRDATA[8]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31]}  {PRDATA[30]}  {PRDATA[29]}  {PRDATA[28]}  {PRDATA[27]}  {PRDATA[26]}  {PRDATA[25]}  {PRDATA[24]}  {PRDATA[23]}  {PRDATA[22]}  {PRDATA[21]}  {PRDATA[20]}  {PRDATA[19]}  {PRDATA[18]}  {PRDATA[17]}  {PRDATA[16]}  {PRDATA[15]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}   }
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[31]}  {PRDATA[30]}  {PRDATA[29]}  {PRDATA[28]}  {PRDATA[27]}  {PRDATA[26]}  {PRDATA[25]}  {PRDATA[24]}  {PRDATA[23]}  {PRDATA[22]}  {PRDATA[21]}  {PRDATA[20]}  {PRDATA[19]}  {PRDATA[18]}  {PRDATA[17]}  {PRDATA[16]}  {PRDATA[15]}  {PRDATA[14]}  {PRDATA[13]}  {PRDATA[12]}  {PRDATA[11]}  {PRDATA[10]}  {PRDATA[9]}  {PRDATA[8]}  {PRDATA[7:0]}   }
gui_exclude_items -id  CovDetail.1  -list { tglDetail }  -selected  -include  -tgl_transition  0to1
gui_list_select -id CovDetail.1 -list tglDetail { {PRDATA[7:0]}   }
gui_list_select -id CovDetail.1 -list tgl { {PRDATA[31:0]}  PSLVERR   }
gui_list_action -id  CovDetail.1 -list {tgl} PSLVERR
gui_list_select -id CovDetail.1 -list tglDetail { PSLVERR   }
gui_list_action -id  CovDetail.1 -list {tglDetail} PSLVERR
gui_exclude_items  -id CovDetail.1  -list tglDetail PSLVERR  -tgl_transition 0to1
gui_list_action -id  CovDetail.1 -list {tglDetail} PSLVERR
gui_list_action -id  CovDetail.1 -list {tglDetail} PSLVERR
gui_list_action -id  CovDetail.1 -list {tglDetail} PSLVERR
gui_list_select -id CovDetail.1 -list tgl { PSLVERR  nDTR   }
gui_list_action -id  CovDetail.1 -list {tgl} nDTR
gui_list_select -id CovDetail.1 -list tgl { nOUT1  nOUT2  nRI  nRTS   }
gui_exclude_items -id  CovDetail.1  -list { tgl }  -selected
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT  -column {} 
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT  top.DUT.control   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT.control  -column {} 
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.control  top.DUT   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT  -column {} 
gui_exclusion  -id  [gui_get_current_window  -view]  -recalculate 
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT   }
gui_covtable_show -show  { Design Hierarchy } -id  CoverageTable.1  -test  MergedTest
gui_cov_src_double_click -id CovSrc.1 -line 55 -col 5 -insert 0 -file /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/../rtl/design.sv
verdiSetActWin -dock widgetDock_<CovSrc.1>
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list tgl { nDTR   }
gui_list_select -id CovDetail.1 -list tgl { nDTR  nRTS   }
gui_list_select -id CovDetail.1 -list tgl { nRTS  nDTR   }
gui_list_select -id CovDetail.1 -list tgl { nOUT1  nOUT2  nRI  nRTS   }
gui_exclude_items -id  CovDetail.1  -list { tgl }  -selected  -include
gui_list_select -id CovDetail.1 -list tgl { nDTR  nOUT1  nOUT2  nRI  nRTS  rx_fifo_empty   }
gui_exclusion  -id  [gui_get_current_window  -view]  -recalculate 
gui_list_select -id CovDetail.1 -list tgl { rx_fifo_empty  rx_fifo_full   }
gui_list_action -id  CovDetail.1 -list {tgl} rx_fifo_full
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT  top   }
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top   }
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top   }
verdiDockWidgetHide -dock widgetDock_<CovDetail>
verdiSetActWin -dock widgetDock_<CovSrc.1>
verdiDockWidgetHide -dock widgetDock_<CovSrc.1>
verdiSetActWin -dock widgetDock_<Summary>
verdiDockWidgetHide -dock widgetDock_Message
verdiDockWidgetHide -dock widgetDock_<ExclMgr>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top   }
gui_list_collapse -id  CoverageTable.1   -list {covtblInstancesList} top
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} top
gui_list_select -id CoverageTable.1 -list covtblInstancesList { uvm_custom_install_recording   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} uvm_custom_install_recording  -column {Branch} 
gui_list_select -id CoverageTable.1 -list covtblInstancesList { uvm_custom_install_recording  top.DUT   }
verdiSetActWin -dock widgetDock_<CovSrc.1>
verdiDockWidgetHide -dock widgetDock_<CovDetail>
verdiDockWidgetHide -dock widgetDock_<CovSrc.1>
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT  top   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top   }
gui_set_pref_value -category {ColumnCfg} -key {covtblInstancesList_V1.1_Branch_width} -value {123}
gui_exclusion_file -save -file { /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/exclusion_file_2.el } -id CoverageTable.1 -list covtblInstancesList -module_mode_supported -tree -module -incremental -format newformat
verdiDockWidgetDisplay -dock widgetDock_Message
verdiSetActWin -dock widgetDock_Message
verdiWindowResize -win $_vdCoverage_1 "313" "85" "1440" "749"
verdiSetActWin -dock widgetDock_<Summary>
verdiSetActWin -dock widgetDock_Message
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.control  top.DUT.rx_channel  top.DUT.tx_channel  top.DUT  top.in  uvm_custom_install_recording  uvm_custom_install_verdi_recording   }
gui_exclusion_file -save -file { /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/exclusion_file_2.el } -id CoverageTable.1 -list covtblInstancesList -module_mode_supported -module -incremental -format newformat
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.control  top.DUT.rx_channel  top.DUT.tx_channel  top.DUT  top.in  top  uvm_custom_install_recording  uvm_custom_install_verdi_recording   }
gui_exclusion_file -load -file { /home/shirley/GIT_CHECKOUT/UART/UART_non_pulpino/sim/exclusion_file_2.el }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top  top.DUT   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT  top.DUT.rx_channel   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.rx_channel  top.DUT.tx_channel   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.tx_channel   }
verdiSetActWin -dock widgetDock_Message
vdCovExit -noprompt
