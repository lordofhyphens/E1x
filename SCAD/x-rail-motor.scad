
// 48mm separation, center to center
rail_separation = 41;
socket_length = 15;
mass_rotate = [0, 0, 90];
mirrorblock = [1, 0, 0];
trans = [33.5, 0, 0];
difference() {
  union() {
    // positive, brackets 
  translate(trans)
    mirror(mirrorblock) {
    rotate(mass_rotate)
    translate([23.5,38,0.45]) 
      translate([10,20,10])rotate([90,0,0])
          scale([1.05,1.05,1.2])ext2020(l=socket_length, teeth=[0,0,0,0],depth=0);
    rotate(mass_rotate)
    translate([23.5,38,rail_separation-2])  
      translate([10,20,10])rotate([90,0,0])
          scale([1.05,1.0,1.2])ext2020(l=socket_length, teeth=[0,0,0,0],depth=0);
}

    difference(){
      translate([60.5,1.5,0.45]) 
        translate([13,20,-0.5])
        cube([18,24,19+rail_separation]);

      translate([40.5,9.5,0.45]) 
        translate([10,20,15])
        color("blue")cube([90,8,30]);
    }

    // positive, the original idler block
    import("src/X_Axis_Motor_Block_-_1x.stl");
  }
  translate(trans)
  mirror(mirrorblock)
  rotate(mass_rotate)
  {
  translate([23.5,38,0.45]) 
    translate([10,20,10])rotate([90,0,0])
    translate([0,0,-3])ext2020(l=20, teeth=[0,0,0,0]);
  translate([23.5,38,rail_separation+0.45]) 
    translate([10,20,10])rotate([90,0,0])
    translate([0,0,-3])ext2020(l=20, teeth=[1,1,0,0],depth=0);
  translate([23.5,38,-5+0.45]) 
    translate([10,20,10])rotate([90,0,0])
    translate([0,0,-3])ext2020(l=20, teeth=[0,0,0,1],depth=0);
  translate([23.5,39,rail_separation+0.45]) 
    translate([-10,10,10])rotate([90,0,90])
    cylinder(r=m5_diameter/2 + 0.1, h=40, $fs=0.1);
  translate([23.5,39,0.45]) 
    translate([-10,10,10])rotate([90,0,90])
    cylinder(r=m5_diameter/2 + 0.1, h=90, $fs=0.1);
}
}



include <configuration.scad>
include <inc/metric.scad>
use <bushing.scad>
use <inc/bearing-guide.scad>
use <inc/functions.scad>
