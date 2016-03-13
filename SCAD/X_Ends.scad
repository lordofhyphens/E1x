tol=0.45;
belt_space_cutout=9.5;
end_body_shift=13;
shifted_rails=end_body_shift-7;
offset_from_rail = (17+6) - 10;
// center it on the Zx extrusion

*translate([0,0,0])ext2020(l=400);

// offset main block 17mm in Y
module x_idler(idler_cutouts=true) {
  width=35;
  length=60;
  difference() {
    union() {
      translate([width/2+offset_from_rail,0,outer_height/2]) union() {
        roundcube([width,length,outer_height], center=true);
      }
      translate([shaft_offset[0],shaft_offset[1],outer_height-(5/2)]) 
        roundcube([20,20,5], center=true);
    }
  translate([width/2+offset_from_rail,length/2 + 10,outer_height/2])
    rotate([90,90,0])#ext2040(l=length+20, teeth=[0,0,0,0,0,1], tolerance=0.4);
  for (i = [0, 15, -20])
  translate([width/2+offset_from_rail,i,outer_height/2])
    #cylinder(d=M5, h=40);
    
  for ( i = [17.5, 24+(vwheel_r()*2)])
    translate([-width/2,(vwheel_r()+10), i])
      rotate([0,90,0])
      {
        #cylinder(d=M5, h=40);
        translate([0,0,38-M5nutThickness])#cylinder(d=M5nut+tolerance*2, h=M5nutThickness, $fn=6);
      }

  for ( i = [outer_height/2])
  translate([-width/2,-(vwheel_r()+10), i])
    rotate([0,90,0])
    {
    #cylinder(d=M5, h=40);
    translate([0,0,38-M5nutThickness])#cylinder(d=M5nut+tolerance*2, h=M5nutThickness, $fn=6);
    }


  #translate([shaft_offset[0],shaft_offset[1],outer_height-5])rotate([0,0,90])znut_holes();

  }
}
module x_motor() {
  x_idler(idler_cutouts=false);
  translate([3,0,0])
  difference() {
    union() {
      translate([30/2+offset_from_rail, -60/2 - 49/2+4,outer_height-4/2])
      roundcube([45,49,4],center=true);
      for (i = [-21, 21])
        translate([30/2+offset_from_rail+i, -60/2,outer_height/2])
        {
          translate([(-i/21)*4.5, 2,0])
          cube([12,4,outer_height],center=true);
          hull() {
            cylinder(d=3, h=outer_height,center=true);
            translate([0,-43,outer_height/2-4])
              cylinder(d=3, h=4);
          }
        }
    }
      for (i = [-21])
        translate([30/2+offset_from_rail+i, -60/2,outer_height/2])
        {
          translate([(-i/21)*4.5, 2,0])
          cube([12,4,outer_height],center=true);
          hull() {
            cylinder(d=3, h=outer_height,center=true);
            translate([0,-43,outer_height/2-4])
              cylinder(d=3, h=4);
          }
        }

    translate([30/2+offset_from_rail, -60/2 - 49/2,outer_height-30])
      #linear_extrude(height=30)stepper_motor_mount(17, mochup=false, tol=tolerance);


  }
}
include <inc/configuration.scad>
use <inc/functions.scad>
outer_height=55;

mirror([0,0,1])
{
x_motor();
mirror([0,1,0])
translate([-60,-60,0])
  x_idler();
}
  use <MCAD/motors.scad>
  use <inc/extrusions.scad>
  use <inc/vslot.scad>
  use <znut.scad>
