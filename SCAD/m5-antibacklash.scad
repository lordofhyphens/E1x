
springod=9.5; 
length=40;
bottom=4;
scale_factor=1.2;
difference() 
{
  union(){
    translate([0,0,(length-bottom)/2])scale([scale_factor,scale_factor,1])cube([springod,springod, length-bottom],center=true);
    translate([0,0,length-bottom])nutHole(size=5);
  }
  translate([0,0,0])nutHole(size=5);
  cylinder(r=springod/2, h=length-5);
  translate([0,0,length-bottom-5])nutHole(size=5);
  cylinder(r=m5_diameter/2 + 0.1, h=length+10);
}
translate([20,0,0]) {
  difference() {
    union() {
      translate([0,0,bottom/2])scale([scale_factor,scale_factor,1])cube([springod,springod, bottom],center=true);
    }
    translate([0,0,bottom-3])nutHole(size=5);
    cylinder(r=m5_diameter/2 + 0.1, h=50);
  }
}

use<MCAD/nuts_and_bolts.scad>;
include<inc/metric.scad>;
