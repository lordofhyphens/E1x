tol=0.45;
belt_space_cutout=9.5;
end_body_shift=13;
shifted_rails=end_body_shift-7;

module x_idler(idler_cutouts=true) {
  difference() {
    union() {
      translate([(lm8uu[1]/2)+3, (lm8uu[1]/2)+3,0]) union() {
        hull() {
          cylinder(r=lm8uu[1]/2 + 3, h = lm8uu[2]*2); // outer
          translate([-((lm8uu[1]/2)+4), -((lm8uu[1]/2)+4),0])
            translate([lm8uu[1]+end_body_shift+4,0,0])
            roundcube([20,30,lm8uu[2]*2]);
        }
      }
      translate([lm8uu[1]+end_body_shift,0,0])roundcube([18,length_to_hole+20,lm8uu[2]*2]);
      translate([(2*26/3)+shifted_rails,length_to_hole-10-35,0])roundcube([32,length_to_hole+25,outer_height]);
      translate([lm8uu[1]+end_body_shift,shaft_offset[1]+zRod-3,0])roundcube([shaft_offset[0]-(lm8uu[1]/2)+3,zRodnut+4+6,3+zRodnutThickness]);
    }

    union() {
      translate([(lm8uu[1]/2)+3, (lm8uu[1]/2)+3,0]) 
      {
        cylinder(r=lm8uu[1]/2-tol, h=lm8uu[2]*2);
        rotate([0,0,-25])
          translate([0,15/2,outer_height/2])cube([2,15,outer_height], center=true);
        translate([shaft_offset[0], shaft_offset[1], 0]) 
        {
          cylinder(r=zRod/2, h=10);
          translate([0,0,3])rotate([0,0,30])cylinder(d=zRodnut + tol*4, h=zRodnutThickness+tolerance, $fn=6);
        }
      }
      translate([28/2+(2*28/3)+shifted_rails,length_to_hole-6.5,0])
        translate([0,-90,0])rotate([0,0,90])union() {
          {
            translate([0,0,(60+tol)/2])
              #rotate([0,90,0])ext2040(l=150, tolerance=tol+.5, teeth=[0,0,1,0,0,0]);
            #translate([104,20,10+10])rotate([90,90,0])cylinder(d=M5 + tol, h = 40);
            #translate([104,20,20+10+10])rotate([90,90,0])cylinder(d=M5 + tol, h = 40);
          }
        }
      for (i = [10, 25, 40, 60, 80])
      {
        translate([lm8uu[1]+23.5,i,-10])#cylinder(d=M5+(tol * 2), h=outer_height);
    }

    }
  }


}
module x_motor() {
  x_idler(idler_cutouts=false);
  difference() {
    union() {
    
      translate([lm8uu[1]+end_body_shift-10,-38-5,0])
      roundcube([45,49,4]);
      hull() translate([lm8uu[1]+end_body_shift-15,0,40])

      {
        translate([0,0,-37])
        rotate([0,90,0])cylinder(r=3,h=7);
        translate([0,-38,-37])
          rotate([0,90,0])cylinder(r=3,h=7);
        translate([0,0,5])
          rotate([0,90,0])cylinder(r=3,h=7);
      }
    }
    translate([28/2+(2*28/3)+shifted_rails+0,-23,0]) 
    #linear_extrude(height=10)stepper_motor_mount(17, mochup=false, tol=tolerance);


  }
}
include <inc/configuration.scad>
use <inc/functions.scad>
outer_height=55;

mirror([0,1,0])
x_motor();
translate([-60,-60,0])
x_idler();

use <MCAD/motors.scad>
use <inc/extrusions.scad>
