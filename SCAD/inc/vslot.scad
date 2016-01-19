include<configuration.scad>

// vwheel
module vwheel(tolerance=0.2) 
{
  $fn=90;
  difference() {
    union() {
      cylinder(r2=23.89/2, r1=9.77, h=((10.23-5.89)/2));// bottom
      translate([0,0,((10.23-5.89)/2)])
      {
        cylinder(r=23.89/2, h=5.89);
        translate([0,0,5.89])cylinder(r1=23.89/2, r2=9.77, h=((10.23-5.89)/2));
      }
    }
    #cylinder(d=M5+(tolerance/2), h=12.3);
  }
}


module vbearing(bearing = true) {
  if (bearing)
  union() {
  cylinder(r1=4, r2=6, h=2);
  translate([0,0,-2])cylinder(r2=4, r1=6, h=2);
  }
  rotate([180,0,0])cylinder(d=M3, h=30);
}
function vwheel_r() = 9.77;
