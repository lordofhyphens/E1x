z_shift=5;
y_tension=15;
width=72;
plate_thickness=7;
difference()
{
  union() {
    translate([0,(y_tension+20)/2,(plate_thickness/2)+z_shift])roundcube([width,y_tension+60,plate_thickness],center=true);
    translate([0,70,5/2])roundcube([width,30,5],center=true);
    translate([0,y_tension+40+4/2,(20+5+z_shift*1.3)/2])cube([width,4,20+5+z_shift*1.3],center=true);
  }
  translate([0,10,z_shift])#linear_extrude(height=10)stepper_motor_mount(23, tolerance=0.4, stretch=y_tension);
  translate([0,35,10+10])
  for (i = [1, -1])
  {
    translate([i*10,y_tension,0])rotate([-90,0,0])#cylinder(d=M5 + 0.2, h=10);
  }
  translate([0,55+y_tension,0])#cylinder(d=M5 + 0.2, h=10);
  translate([0,1,z_shift])
  for (i = [1, -1]) {
    translate([i*23.5,-22,M3])rotate([-90,0,0])#cylinder(d=M3 + 0.2, h=10);
    translate([i*23.5,-18,M3])
    hull() {
      translate([0,0,0])rotate([-90,0,0])#cylinder(d=M3nut + 0.2, h=M3nutThickness+3, $fn=6);
      translate([0,0,-3])rotate([-90,0,0])#cylinder(d=M3nut + 0.2, h=M3nutThickness+4, $fn=6);
    }
  }
}
difference() {
  union() {
    for (i = [1, -1]) {
      hull() {
        translate([i*width/2,0,0])cylinder(d=M3,h=12+z_shift);
        translate([i*width/2,y_tension+40+4-M3/2,0])cylinder(d=M3,h=30+z_shift);
      }
    }
  }
}
include <inc/configuration.scad>
include<inc/metric.scad>;
include<MCAD/nuts_and_bolts.scad>;
include<MCAD/motors.scad>;
use<inc/functions.scad>;
