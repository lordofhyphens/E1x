padding=18;
top_width=14.2;
top_length=25;
width=20;
hole_spacing=49; // lulzbot 300mm bed plate
hole_offset=5;
hole_size=3; // M3
length=hole_spacing+(hole_offset*2)+hole_size/2;

module beltloop(belt_gap=1.8, wall_thick=3.2,circle_rad = 2.5, belt_width=6.2)
{
  hull() {
  translate([top_width-(circle_rad+wall_thick+belt_gap),circle_rad,0])
    cylinder(r=circle_rad,h=6.2,$fn=60);
  translate([top_width-(0.2+wall_thick+belt_gap),8,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  }
  hull() {
  translate([top_width-(circle_rad+wall_thick+belt_gap),20+circle_rad,0])
    cylinder(r=circle_rad,h=6.2,$fn=60);
  translate([top_width-(0.2+wall_thick+belt_gap),17,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  }
  hull() {
  translate([top_width-(0.2+wall_thick+belt_gap),12,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  translate([top_width-(6+2.2+belt_gap),8,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  translate([top_width-(0.2+wall_thick+belt_gap),14,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  translate([top_width-(6+2.2+belt_gap),18,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  }

  translate([top_width-wall_thick,0,0])
    cube([wall_thick,top_length,belt_width]);
}
difference() {
  union() {
    cube([width,length,padding]);
    translate([width-top_width,12.63,padding+16.9])beltloop();
  }
  // mounting holes to the bed
  translate([20/2,hole_offset+hole_size/2, 0])cylinder(r=hole_size/2 + 0.1, h=padding);
  translate([20/2,hole_spacing+(hole_offset+hole_size/2), 0])cylinder(r=hole_size/2 + 0.1, h=padding);
}

difference() {
  hull() {
    translate([width-top_width,12.63-3,padding+16.8])cube([top_width,top_length+6,.1]);
    translate([0,12.63-3,padding])cube([width,top_length+6,.1]);
  }
  for ( i = [12.63-3, 12.63 + 25 + 3])
  hull() {
    translate([0,i,padding+3])rotate([0,90,0])cylinder(r=3, h=width,$fn=60);
    translate([0,i,padding+3+40])rotate([0,90,0])cylinder(r=3, h=width,$fn=60);
  }
}
difference() {
  translate([width,12.63,0]) 
  {
    hull() {
      translate([0,0,33.8])cube([19,4,3.1]);
      translate([0,0,padding])cube([5,4,0.1]);
    }
      translate([0,0,0])cube([5,4,padding]);
  }
  hull() {
    translate([0,0,33.8+3])
      translate([width+3,12.63,0]) 
      rotate([-90,0,0])cylinder(r=3,h=top_length, $fn=60);
    translate([0,0,33.8+3])
      translate([width+19,12.63,0]) 
      rotate([-90,0,0])cylinder(r=3,h=top_length, $fn=60);
  }
}
