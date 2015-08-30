tolerance=0.25;
belt_space_cutout=9.5;
end_body_shift=13;
shifted_rails=end_body_shift-7;

module nut_bracket(shadow=false, type="8x8_square") {
  if (type == "8x8_square")
    end_bracket_8x8(shadow);
}

module end_bracket_8x8(shadow=false) {
  translate([0,0,-2]) {
    if (shadow == true) 
      for (i = [-10, 10])
        translate([i,0,0])
        { 
          cylinder(r=M5/2 - tolerance, h=10);
          if (i == -10) {
            hull() {
               
              translate([0,0,6])cylinder(r=M5nut/2+tolerance, h=M5nutThickness, $fn=6);
              translate([-20,0,6])cylinder(r=M5nut/2+tolerance, h=M5nutThickness, $fn=6);
            }
          } else {
          translate([0,0,6])cylinder(r=M5nut/2, h=M5nutThickness, $fn=6);
          }
        }
    if (shadow == false) 
      difference() {
        cube([40,20,4], center=true);
        translate([0,0,-4])cylinder(r=M8/2, h=40);
        for (i = [-10, 10])
          translate([i,0,0])
              {
                cylinder(r=M5/2, h=40);
                translate([0,0,10])cylinder(r=M5nut/2, h=M5nutThickness);
              }
      }
  }
}
translate([100,100,2]) end_bracket_8x8(true);
module x_idler(idler_cutouts=true) {

  difference() {
    union() {
      translate([(lm8uu[1]/2)+3, (lm8uu[1]/2)+3,0]) union() {
        hull() {
          cylinder(r=lm8uu[1]/2 + 3, h = lm8uu[2]*2); // outer
          translate([-((lm8uu[1]/2)+4), -((lm8uu[1]/2)+4),0])
            translate([lm8uu[1]+end_body_shift+4,0,0])roundcube([lm8uu[1],lm8uu[1],lm8uu[2]*2]);
        }
      }
      translate([lm8uu[1]+end_body_shift,0,0])roundcube([18,length_to_hole+20,lm8uu[2]*2]);
      translate([(2*28/3)+shifted_rails,length_to_hole-10,0])roundcube([28,30,outer_height]);
      translate([lm8uu[1]+end_body_shift+(zRod-M5),shaft_offset[1]+zRod-3-(zRod-M5),0])roundcube([shaft_offset[0]-(lm8uu[1]/2)+3 + (zRod-M5),zRodnut+4+6+(zRod-M5),3+zRodnutThickness]);
    }

    union() {
      translate([(lm8uu[1]/2)+3, (lm8uu[1]/2)+3,0]) 
      {
        cylinder(r=lm8uu[1]/2-tolerance, h=lm8uu[2]*2);
        rotate([0,0,-25])
          translate([0,15/2,outer_height/2])cube([2,15,outer_height], center=true);
        translate([shaft_offset[0], shaft_offset[1], 0]) 
        {
          nut_bracket(shadow=true);
          cylinder(r=zRod/2 + tolerance, h=10);
          translate([0,0,3])cylinder(r=zRodnut/2 + tolerance, h=zRodnutThickness+tolerance, $fn=6);
        }
      }
      translate([28/2+(2*28/3)+shifted_rails,length_to_hole-6.5,0])
        translate([0,0,0])rotate([0,0,90])union() {
          translate([0,0,rail_separation])
          {
            translate([0,0,(20+tolerance)/2])
              rotate([0,90,0])ext2020(l=31, tolerance=tolerance, teeth=[1,0,0,0]);
            translate([14,15,10])rotate([90,90,0])cylinder(r=M5/2 + tolerance, h = 30);
          }
          translate([0,0,(20+tolerance)/2])
            rotate([0,90,0])
            ext2020(l=31, tolerance=tolerance,teeth=[0,0,0,0] );
          translate([14,15,10])rotate([90,90,0])cylinder(r=M5/2 + tolerance, h = 30);
        }

      translate([28/2+(2*28/3)+shifted_rails,0,20+1]) translate([0,0,belt_z_space/2]) rotate([90,0,0])roundcube([belt_space_cutout, belt_z_space,300], center=true);
      if (idler_cutouts) {
        translate([28/2+(2*28/3)+shifted_rails,0,20+1]) translate([-7,5,belt_z_space/2]) 
        rotate([0,90,0])cylinder(r=M3/2+tolerance, h=20);
        translate([28/2+(2*28/3)+shifted_rails,0,20+1]) translate([-6.4,5,belt_z_space/2]) 
        rotate([0,90,0])cylinder(r=M3nut/2+tolerance, h=M3nutThickness, $fn=6);
      }

    }
  }


}
module x_motor() {
  x_idler(idler_cutouts=false);
  difference() {
    union() {
      translate([lm8uu[1]+end_body_shift,-38-5,0])roundcube([5,49,20]);
      hull() translate([lm8uu[1]+end_body_shift,0,40])
      {
        rotate([0,90,0])cylinder(r=3,h=7);
        translate([0,-11,5])
          rotate([0,90,0])cylinder(r=3,h=7);
        translate([0,0,5])
          rotate([0,90,0])cylinder(r=3,h=7);
      }
    }
    translate([28/2+(2*28/3)+shifted_rails+0,-23,20+1]) translate([-12,0,belt_z_space/2])rotate([0,90,0])linear_extrude(height=10)stepper_motor_mount(17, mochup=false, tolerance=tolerance);

  }
}
include <inc/configuration.scad>
use <inc/functions.scad>
outer_height=rail_separation+20+tolerance-1;

mirror([0,1,0])
x_motor();
translate([-60,-60,0])
x_idler();

use <MCAD/motors.scad>
