
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name connect_four -dir "D:/ECE3135/final project/connect_four/planAhead_run_1" -part xc3s250ecp132-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "connect_four_top.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {sync.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {deb.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {connect_four_vga.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {connect_four.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {connect_four_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top connect_four_top $srcset
add_files [list {connect_four_top.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s250ecp132-4
