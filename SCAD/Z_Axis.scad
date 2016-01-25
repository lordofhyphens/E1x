

tolerance=0.4;

module z_lower(height, panel_height, motor=false) {
  rod=8;
  depth=10;
  tab_length=93;
  fastener_hole=M5; 
  base_length=77-13; 
  z_rod_to_extrusion=length_to_hole-(rod/2)-13;
  base_width=z_rod_to_extrusion+13+25;
  back_wall_y=z_rod_to_extrusion+13+5;

  difference() {
    union() {
      hull() {
        translate([-10,z_rod_to_extrusion,height/2])roundcube([46,26,height], r=3,center=true);
      }
      if (motor) {
        translate([-29,z_rod_to_extrusion+13,0])roundcube([tab_length, 30, panel_height]);
        hull() {
          translate([0,-17/2,0])roundcube([base_length, base_width, panel_height]);
          hull() {
            translate([0,z_rod_to_extrusion,panel_height/2])roundcube([26,26,panel_height], center=true);
          }
        }
        hull() {
          translate([-13+4,back_wall_y,height-3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([13-3,back_wall_y,height-3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([-13-13,back_wall_y,3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([-13-13,back_wall_y,height/2-3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([base_length-3,back_wall_y,3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([base_length-3,back_wall_y,height/2 - 3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
        }
        hull() {
          translate([base_length,back_wall_y-3,height/2 -3])
            rotate([00,-90,0])cylinder(r=3,h=thickness);
          translate([base_length,back_wall_y-3,3])
            rotate([00,-90,0])cylinder(r=3,h=thickness);
          translate([base_length,-3, 3])
            rotate([00,-90,0])cylinder(r=3,h=thickness);
        }
      }
      else {
        hull() {
          translate([-13-16,back_wall_y,height-3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([13-3,back_wall_y,height-3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([-13-33,back_wall_y,3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([-13-33,back_wall_y,height/2-3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([base_length-3,back_wall_y,3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
          translate([base_length-3,back_wall_y,height/2 - 3])
            rotate([90,0,0])cylinder(r=3,h=thickness);
        }
        translate([-29-20,z_rod_to_extrusion+13,0])roundcube([tab_length+20, 30, panel_height]); //bottom tab

        hull() {
          hull() {
            translate([-10,z_rod_to_extrusion,panel_height/2])roundcube([46,26,panel_height], center=true);
          }
        }
      }
    }
    // subtractions
    for (j = [0, -20])
    for (i = [20, 40])
      translate([j,0,i])
        rotate([-90,0,0]) #cylinder(d=M5+tolerance*2, h=60);
    translate([0,0,height-depth]) cylinder(r=rod/2 + tolerance,h=height);
    cylinder(r=rod/4,h=height);
    if (motor)
    {
      translate([shaft_offset[0],shaft_offset[1],0])linear_extrude(height=10)stepper_motor_mount(17, mochup=false, tolerance=tolerance);
    }
    translate([-10,z_rod_to_extrusion,panel_height]) 
    {
      #ext2040(l=height,depth=0.75, tolerance=tolerance);
      translate([-15,0,(15/2)+3])rotate([0,90,0])cylinder(r=M5/2+tolerance, h=30);
      translate([-15,0,height-15])rotate([0,90,0])cylinder(r=M5/2+tolerance, h=30);
    }
    translate([0,z_rod_to_extrusion,panel_height]) cube([7,7,height],center=true);

    union() {
      for (i = [ 55, 25 ,-35])
      #translate([i,back_wall_y+10,0]) cylinder(r=fastener_hole/2+ tolerance, h=10);

      for (i = [ 50, 25 , -40])
      translate([i,back_wall_y,panel_height])
        translate([0,0,10])rotate([90,0,0]) cylinder(r=fastener_hole/2 + tolerance, h=10);
    }
  }

}
module z_upper(height=25, tolerance=0.2, motor=true)
{
  rod=8;
  length_to_hole=43;
  depth=height-3;
  tab_length=93;
  fastener_hole=M5; 
  base_length=77-13; 
  // length from center of rod to center of extrusion
  z_rod_to_extrusion=length_to_hole-(rod/2)-13;
  base_width=z_rod_to_extrusion+13+25;
  back_wall_y=z_rod_to_extrusion+13+5;
  difference() {
    union() {
      hull() {
        translate([0,z_rod_to_extrusion,height/2])roundcube([26,26,height], r=3,center=true);
        translate([0,z_rod_to_extrusion+26,height/2])roundcube([26,26,height], r=3,center=true);
        cylinder(r=17/2, h= height);
      }
      if (motor) {
        translate([0,-8,0])roundcube([70,45,3]);
        for (i = [1.5, 44]){ 
          translate([0,i,0])
            hull(){
              wall_width = 2;
              translate([wall_width,-10+wall_width,height-wall_width])rotate([0,90,0])cylinder(r=wall_width,h=wall_width);
              translate([-2*wall_width+70,-10+wall_width,wall_width])rotate([0,90,0])cylinder(r=wall_width,h=wall_width);
              translate([wall_width,-10+wall_width,wall_width])cube([wall_width*2,wall_width*2,wall_width*2],center=true);
            }
        }
      }
    }
    translate([0,0,height-depth]) cylinder(r=rod/2 + tolerance,h=height);
    cylinder(r=rod/4,h=height);
    translate([-10,z_rod_to_extrusion,3]) {
      #ext2040(l=26, depth=0.75, tolerance=tolerance);
      cube([10,10,10],center=true);
    }
    #translate([0,13+3+z_rod_to_extrusion,3+20/2])rotate([-90,0,0])ext2020(l=26, depth=0.75,teeth=[0,0,1,0], tolerance=tolerance);
    for (y = [53, 26]) 
      translate([-20,y,((height-3) / 2)+3])rotate([0,90,0])cylinder(r=M5/2 + tolerance, h=40);
    if (motor) {
      translate([shaft_offset[0],shaft_offset[1],0])linear_extrude(height=10)stepper_motor_mount(17, mochup=false, tolerance=tolerance);
    }
  }
}
translate([0,-100,0]) z_upper(height=23);
translate([-50,-100,0]) mirror([1,0,0]) z_upper(height=23);
z_lower(height=54, panel_height=3.17);
translate([0,150,0])mirror([0,1,0]) z_lower(height=54, panel_height=3.17);

use <inc/functions.scad>
use <MCAD/motors.scad>
include<inc/configuration.scad>
use <inc/extrusions.scad>
