module znut(invert=false) {
  $fs=0.1;
  $fa=0.1;
  if (!invert)
  {
    difference() {
      cylinder(d=zRod + 20, h=20);
      #znut_holes();
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
  for (i = [0, 2*360/3,360/3])
    rotate([0,0,i])
      translate([(3/2)+(5/2)+2.75,0,0]) cylinder(d=M3-0.3, h=20);
}

include<inc/configuration.scad>
