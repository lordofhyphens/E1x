
//length: 179mm (??) - 7mm fudge = 172mm
//height: 368mm

//hyp: 406.21177
//lower-angle: 63.83953
//upper-angle: 24.986961

y1_length = 149;
y2_length = (485+40 - y1_length);
z_height = 388;
fudge_y=7;
fudge_z=0;
hyp1 = sqrt(pow((y1_length-fudge_y),2) + pow(z_height-fudge_z,2));
hyp2 = sqrt(pow((y2_length-fudge_y),2) + pow(z_height-fudge_z,2));

angles1 = [acos(y1_length/hyp1), 90, acos(z_height/hyp1)];
angles2 = [acos(y2_length/hyp2), 90, acos(z_height/hyp2)];
module support_cyl(r, h)
{
  difference() {
    cylinder(r=r, h=h);
    cylinder(r=r-0.4, h=h);
  }
}
echo("Your short bracing extrusion needs to be " );
echo(hyp1);
echo("mm long.");
echo("Your long bracing extrusion needs to be " );
echo(hyp2);
echo("mm long.");
echo("Lower short angle: ");
echo(angles1[2]);
echo("upper short angle: ");
echo(angles1[0]);
translate([0,0,12.5]) {
  lower_bracket(angles1, tolerance=0.5);
  translate([-60,0,0])mirror([0,1,0])lower_bracket(angles1);
}
translate([0,-90,15]) 
{
  rotate([0,-90,0])upper_bracket_single(angles1, fudge_y);
  translate([0,33,0])mirror([0,1,0]) rotate([0,-90,0])
    upper_bracket_single(angles1, fudge_y);
}

module upper_bracket_single(angle1, fudge, support = true, tolerance=0.5)
{
  {
    difference() 
    {
      union() 
      {
        translate([0,0,-3.5])roundcube([30,30,58],center=true);
        rotate([0,90,0])
        translate([20,0,40/2 - 15])roundcube([30,30,40],center=true);
      }
      translate([0,0,10])
        rotate([0,angles1[0],0])
        {
          #ext2020(l=40, teeth=[0,0,1,1], depth=1.8, tolerance=tolerance);
          translate([0,30,8])rotate([90,0,0])cylinder(r=M5/2 + tolerance, h=60);
        }
      #translate([-25,0,-20])rotate([0,90,0])ext2020(l=60,teeth=[0,0,0,0], tolerance=tolerance);
      translate([-25,0,-25])rotate([0,90,0])ext2020(l=55,teeth=[0,0,0,0], tolerance=tolerance);
      for (z = [-5, 15])
        translate([z,22,-20])rotate([90,0,0])cylinder(r=M5/2 + tolerance, h=60); 
    }
  }
}

module upper_bracket(angle1, angle2, fudge, support = true)
{
  difference() 
  {
    union() 
    {

      translate([0,0,-9.3])rotate([0,0,90])import("src/Z_Top_Compact_-_2x.stl");
      translate([-17.5,0,0])roundcube([15,25,25], center=true);
      translate([17.5,0,0])roundcube([15,25,25], center=true);

      translate([20+fudge, 0, 0]) rotate([0,angle1[0],0]) roundcube([25,25,45], center=true);
      translate([-(20+fudge), 0, 0]) rotate([0,-angle2[0],0]) roundcube([25,25,45], center=true);

    }
    ext2020(l=20);
    translate([20+fudge, 0, 0]) rotate([0,angle1[0],0]) 
    {
      ext2020(l=40, teeth=[1,0,1,1] );
    }
    translate([-(20+fudge), 0, 0]) rotate([0,-angle2[0],0]) {
      ext2020(l=40, teeth=[0,1,1,1]);
    }
    translate([0, 0, 0]) rotate([0,angle1[0],0]) 
      translate([-25,15,-29]) rotate([90, 0, 0])cylinder(r=5/2 + 0.1, h=30);
    translate([0, 0, 0]) rotate([0,-angle2[0],0]) 
      translate([30,15,-24]) rotate([90, 0, 0])cylinder(r=5/2 + 0.1, h=30);

    ext2020(l=20);
    translate([0,0,-8])cube([5,5,30], center=true);

    translate([-100,-100,-32.5])cube([200,200,20]);
  }
}

module lower_bracket(angles, support=true, tolerance=0.4) 
{
  back_wall_y=z_rod_to_extrusion+13+5+10;
  difference() {
    union() {
      rotate([0,90,0]) 
        translate([0,-25.5,-5])cube([25,28.5,30], center=true);
      {
        translate([-1,0,-3])
          rotate([0,angles[2],0]) 
          difference()
          { 
            translate([0,-(2.5+back_wall_y),5])roundcube([30,30,40], center=true);
            translate([-15,0,10])rotate([0,90,0])cylinder(r=M5/2 + tolerance, h=30);
          }
      }
    }
    translate([-1,0,-3])
      rotate([0,angles[2],0]) 
      translate([0,-(5+back_wall_y),0])
      {
        translate([0,0,5])ext2020(l=50, teeth=[1,1,1,0], tolerance=tolerance, depth=2);
        ext2020(l=10, teeth=[1,1,1,0], tolerance=tolerance, depth=3);
      }

    #translate([0,-13,0])rotate([90,0,0])ext2020(l=50, teeth=[0,0,0,1], tolerance=tolerance);
    #translate([16,-13,0])rotate([90,0,0])ext2020(l=50, teeth=[0,0,0,0], tolerance=tolerance);
    #translate([16,-13,6])rotate([90,0,0])ext2020(l=50, teeth=[0,0,0,0], tolerance=tolerance);
    #translate([0,-25,-14])cylinder(r=M5/2 + tolerance, h=40);
    #translate([-20,-25,0])rotate([0,90,0])cylinder(r=M5/2 + tolerance, h=40);
    #translate([-100,-100,-32.5])cube([200,200,20]);
  }
  translate([6,-38,-11])
    difference(){
      cylinder(r=1, h=21.5);
      cylinder(r=0.5, h=21.5);
    }
}
include <inc/configuration.scad>
include<inc/metric.scad>;
include<MCAD/nuts_and_bolts.scad>;
use<inc/functions.scad>;

