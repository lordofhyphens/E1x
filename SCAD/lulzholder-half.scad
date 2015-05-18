// Belt holder alternative for Lulzbot's 300x300 y carriage. 
// should be a 26mm separation between the top of the belt and the bottom of the chassis.
height=9+9; // 
hole_separation=49;
use <MCAD/nuts_and_bolts.scad>

difference() {
  cube([19.95,hole_separation+11,height]);
  translate([19.95/2,6,0]) 
  {
    cylinder(r=3.2/2, h=10+height, $fs=0.2);
    translate([0,0,height-2.4])nutHole(size=4);
    translate([0,hole_separation,0])cylinder(r=3.2/2, h=10+height, $fs=0.2);
    translate([0,hole_separation,height-2.4])nutHole(size=4);
  }
}
translate([0.2,9.7,height])
  mirror([0,0,0]) {
    import("ybelt.stl");
    translate([0,0,-height])linear_extrude(height=height)projection(cut=true)import("ybelt.stl");
  }
