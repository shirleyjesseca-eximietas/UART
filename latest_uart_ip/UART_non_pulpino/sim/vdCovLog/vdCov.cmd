verdiWindowResize -win $_vdCoverage_1 "0" "32" "1920" "1131"
gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
verdiSetFont  -font  {DejaVu Sans}  -size  11
verdiSetFont -font "DejaVu Sans" -size "11"
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
verdiWindowResize -win $_vdCoverage_1 "0" "32" "1920" "1131"
verdiSetActWin -dock widgetDock_Message
gui_open_cov  -hier coverage_compile.vdb -testdir  {coverage_compile.vdb} -test { coverage_compile/test1 coverage_compile/test10 coverage_compile/test11 coverage_compile/test12_1 coverage_compile/test12_2 coverage_compile/test12_3 coverage_compile/test12_4 coverage_compile/test12_5 coverage_compile/test12_6 coverage_compile/test12_7 coverage_compile/test12_8 coverage_compile/test12_9 coverage_compile/test13 coverage_compile/test14 coverage_compile/test15 coverage_compile/test16 coverage_compile/test17 coverage_compile/test18 coverage_compile/test19 coverage_compile/test2 coverage_compile/test20 coverage_compile/test3 coverage_compile/test4 coverage_compile/test5 coverage_compile/test6 coverage_compile/test7 coverage_compile/test8 coverage_compile/test9 } -merge MergedTest -db_max_tests 10 -sdc_level 1 -fsm transition
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} top
verdiSetActWin -dock widgetDock_<Summary>
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} top.DUT
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} top.DUT.tx_channel
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.tx_channel   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT.tx_channel  -column {} 
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.tx_channel  top.DUT.control   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { top.DUT.control  top.DUT.tx_channel   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} top.DUT.tx_channel  -column {FSM} 
gui_covdetail_select -id  CovDetail.1   -fsmShow   List
verdiSetActWin -dock widgetDock_<CovDetail>
