// 2020 holder for Y

rotate([0,180,0])y_rod_holder(rod=10);

module y_rod_holder(rod=8) {
  difference() {
    union() {
      hull() {
        cylinder(r=(rod/2)+0.1+2, h = 15, $fn=60);
        translate([0,-20,10])rotate([90,0,0])cube([15,10,5],center=true);
      }
    }
    translate([0,-12-(rod/2),0])cylinder(r=5.1/2,h=15,$fn=60);
    translate([0,0,3])cylinder(r=(rod/2)+0.1, h = 15, $fn=60);
    translate([0,-12-(rod/2),2]) color("red") cube([20,20,20],center=true);
  }
}
