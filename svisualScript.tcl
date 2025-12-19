#/home/ist25.10/Desktop/prova2_sgro/tmp/g_integratedsystemstech.openstack.polito_2533548_0.tmp/vsualScript2.tcl
#MAKO: Output from Tcl commands history.
# load_file /home/ist25.10/Desktop/prova2_sgro/tmp/g_integratedsystemstech.openstack.polito_2533548_0.tmp/n@node@_presimulation_fps.tdr
load_file ../n@node@_presimulation_fps.tdr
create_plot -dataset n_node__presimulation_fps
select_plots {Plot_n_node__presimulation_fps}
#-> Plot_n_node__presimulation_fps
#-> Plot_n_node__presimulation_fps
#-> n_node__presimulation_fps
start_movie -resolution 991x621
#zoom_plot -plot Plot_n_node__presimulation_fps -factor 1.1
#zoom_plot -plot Plot_n_node__presimulation_fps -factor 1.21
#zoom_plot -plot Plot_n_node__presimulation_fps -factor 1.94872
## move_plot -plot Plot_n_node__presimulation_fps -position {0.0192852 -0.093072}
##-> 0
## move_plot -plot Plot_n_node__presimulation_fps -position {0.00922336 -0.168536}
##-> 0
## move_plot -plot Plot_n_node__presimulation_fps -position {0.0134158 -0.17189}
##-> 0
#zoom_plot -plot Plot_n_node__presimulation_fps -factor 1.1
#zoom_plot -plot Plot_n_node__presimulation_fps -factor 1.1
#zoom_plot -plot Plot_n_node__presimulation_fps -factor 1.1
#zoom_plot -plot Plot_n_node__presimulation_fps -factor 1.1
#zoom_plot -plot Plot_n_node__presimulation_fps -factor 0.909091
#move_plot -plot Plot_n_node__presimulation_fps -position {0.0519437 -0.00240533}
#-> 0
zoom_plot -plot Plot_n_node__presimulation_fps -window {-0.0974907 -0.326749 0.202625 0.351583}
# export_view /home/ist25.10/Desktop/prova2_sgro/tmp/g_integratedsystemstech.openstack.polito_2533548_0.tmp/img/final_test.png -plots {Plot_n_node__presimulation_fps} -format png -overwrite
export_view ../img/final_test.png -plots {Plot_n_node__presimulation_fps} -format png -overwrite
#-> 0
stop_movie
#-> 0
exit
