module znut(invert=false) {
  $fs=0.1;
  $fa=0.1;
  if (!invert)
  {
    difference() {
      cylinder(d=zRod + 12, h=20);
      znut_holes();
      translate([0,14,10])
        cube([20,20,20], center=true);
    }
  }
  else {
    znut_holes();
  }
}
znut();
module znut_holes() {
  $fs=0.1;
  $fa=0.1;
  cylinder(d=zRod, h=20);
  for (i = [0, 180,270])
    rotate([0,0,i])
      translate([6,0,0]) cylinder(d=M3-0.3, h=20);
}
include<inc/configuration.scad>
