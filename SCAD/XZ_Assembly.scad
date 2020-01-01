
use <inc/extrusions.scad>
use <X_Ends.scad>
use <Z_Axis.scad>

mirror([0,1,0])x_motor();
translate([10,0,100]) mirror([0,1,0]) mirror([0,0,1])z_upper_long();
*ext2040(l=100);
