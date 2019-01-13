module rim(spacer = 2, fender = 2) {
  difference() {
  union() {
  cylinder(d=17, h=fender);
  translate([0,0,fender])
    cylinder(d=8, h=spacer);
  }
  cylinder(d=5.6, h=spacer + fender);
  }
}

module idler_625x2() {
  difference() {
    translate([-2+4,-10,3-2.5+10])cube([33,20,47], center=true);
    translate([15,5,47])
      rotate([90,0,0])
      #cylinder(d=60,h=33);
      translate([1,5,0])
      rotate([90,0,0])

      #ext2020(l=40, teeth=[0,0,1,0]);
      translate([1,5,-19])
      rotate([90,0,0])
      #ext2020(l=40, teeth=[0,0,0,0]);
      translate([1,-10,0])  {
        #cylinder(d=M5, h=45, center=true);
        translate([0,0,20]) 
          #cylinder(d=10, h=15, center=true);
      }
    rotate([0,90,0])
      translate([0,-10,14]) 
      #cylinder(d=M5, h=40, center=true);
  }
  shift = 10;
  _625 = 5.3;
  bearings = 1;
  rim = 4;
  shim = 2;
  wall_thick = 4;
  translate([-20-6,-10,-12+shift]) 
    difference() {
      union(){ 
        for (i = [rim*2+(_625*bearings)+shim*2+2*wall_thick-2, -3])
          translate([10,10,i])
            rotate([90,0,0]) cylinder(d=8,h=20);
        { //lower
          cube([24,20,wall_thick], center=true); 
          translate([0,0,wall_thick*0.5]) cylinder(r1=6, r2=4,h=shim); 
        }
        { // upper
          translate([0,0,wall_thick+shim*2+rim*2+_625*bearings ]) {
            translate([0,0,-wall_thick*0.5-shim]) cylinder(r1=4, r2=6,h=shim);
            cube([24,20,wall_thick], center=true);
          }
        }
      }
      #cylinder(d=M5, h=60, center=true);
    }
}
mirror([0,0,1])
  rotate([90,0,0])idler_625x2();
translate([50,0,0]) rim();
translate([50,20,0]) rim();
include<inc/configuration.scad>
include<inc/functions.scad>
include<inc/extrusions.scad>
