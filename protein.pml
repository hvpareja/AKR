# show it as blue/magenta spheres
 
as spheres
 
color lightblue, not org
 
color magenta, org
 
remove solvent
 
# set the view
 

orient all within 8 of org
set field_of_view, 35
 
# set the lights, ray tracing setttings
# to get the Goodsell-like rendering
 
unset specular
 
set ray_trace_gain, 0
 
set ray_trace_mode, 3
 
bg_color white
 
set ray_trace_color, black
 
unset depth_cue

set ray_opaque_background, 0

ray