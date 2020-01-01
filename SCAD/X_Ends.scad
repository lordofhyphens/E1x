ECCENTRIC=7.25;
tol=0.45;
belt_space_cutout=9.5;
end_body_shift=13;
shifted_rails=end_body_shift-7;
// center it on the Zx extrusion

*translate([0,0,0])ext2020(l=400);

// offset main block 17mm in Y
module x_idler(idler_cutouts=true) {
    width=35;
    length=80;
    echo ("Block distance from origin:",offset_from_rail);
    translate([offset_from_rail, 0, 0])
        difference() {
            union() {
                translate([width/2,0,outer_height/2]) union() {
                    roundcube([width,length,outer_height], center=true);
                }
                // extended lip for threaded rod
                translate([5+shaft_offset[0],shaft_offset[1],outer_height-(7/2)]) 
                    roundcube([30,40,7], center=true);
            }
            translate([0,0,13])
                rotate([0,0,-90])
                #wheel_array();
                translate([width/2+7,0,40/2+8])
                #cube([width,length,40], center=true);
                // Mounting holes
                for (i = [-10, 30, 10])
                    translate([width/2,i,0])
                        #cylinder(d=M5, h=140);
            echo("ZNut relative to origin:", offset_from_rail+ 5+shaft_offset[0],shaft_offset[1]);
            #translate([5+shaft_offset[0],shaft_offset[1],outer_height-15])rotate([0,0,60])znut_holes(rod=8, holes=4);
        }
}

module motor_mount (shadow=false) {
    difference() {
        union() {
            translate([30/2+offset_from_rail, -60/2 - 49/2+4,outer_height-7/2])
                roundcube([45,49,7],center=true);
            for (i = [21])
                translate([30/2+offset_from_rail+i, -60/2,outer_height/2])
                {
                    translate([(-i/21)*4.5, 2,0])
                        cube([12,8,outer_height],center=true);
                    *hull() {
                        cylinder(d=3, h=outer_height,center=true);
                        translate([0,-43,outer_height/2-4])
                            cylinder(d=3, h=4);
                    }
                }
        }
        for (i = [-21])
            translate([30/2+offset_from_rail+i, -60/2,outer_height/2])
            {
                translate([(-i/21)*4.5-5, -20,0])
                    #cube([7,60,outer_height],center=true);
            }

        if (shadow == false)
            translate([30/2+offset_from_rail, -60/2 - 49/2,outer_height-30])
                #linear_extrude(height=40)stepper_motor_mount(17, mochup=false, tolerance=tolerance);

    }
}
module x_motor() {
    shift_x=3;
    shift_y=20;
    difference() {
        x_idler(idler_cutouts=false);
        translate([shift_x,shift_y,0])
            motor_mount(shadow=true);
    }
    translate([shift_x,shift_y,0])
        motor_mount();



}
include <inc/configuration.scad>
use <inc/functions.scad>
outer_height=55;
    rotate([0,-90,0])
mirror([0,0,1])
{
    x_motor();
    mirror([0,1,0])
        translate([0,-90,0])
        x_idler();
}

module wheel_array(separation=22.3, z_sep = 20) {
    for (x = [-1, 1], z = [0, 1.5]) {
        translate([x*separation, 0, z*z_sep])
            rotate([-90,0,0])
            {
                cylinder(d=(x == -1 ? M5 : ECCENTRIC)+tolerance, h=10);
                if (x == -1)
                    translate([0,0,2])
                    cylinder(d=M5nut+tolerance, h=M5nutThickness+5, $fn=6);
            }

    }
}

use <MCAD/motors.scad>
use <inc/extrusions.scad>
use <inc/vslot.scad>
use <znut.scad>
