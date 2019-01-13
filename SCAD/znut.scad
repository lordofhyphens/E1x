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
module znut_holes(rod=5, holes=3) {
  $fs=0.1;
  $fa=0.1;
  if (rod == 5) {
      cylinder(d=M5 + 0.6, h=20);
  } else if (rod == 8) {
      cylinder(d=M8+0.6, h=20);
  }
  for (i = [1:holes+1])
    rotate([0,0,i*(360/holes)])
      if (rod == 5) {
          translate([(3/2)+(5/2)+2.75,0,0]) cylinder(d=M3-0.3, h=20);
      } else if (rod == 8) {
          translate([8,0,0]) cylinder(d=M3-0.3, h=20);
      }
}

include<inc/configuration.scad>
