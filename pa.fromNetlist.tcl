
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name cevacelalfa -dir "C:/My_Designs/cevacelalfa/planAhead_run_1" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/My_Designs/cevacelalfa/ROM_CUVINTE.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/My_Designs/cevacelalfa} }
set_property target_constrs_file "UCF1.ucf" [current_fileset -constrset]
add_files [list {UCF1.ucf}] -fileset [get_property constrset [current_run]]
link_design
