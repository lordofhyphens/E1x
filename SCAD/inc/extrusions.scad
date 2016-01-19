module ext4040(l=20, teeth = [1, 1, 1, 1, 1, 1, 1, 1], depth=1.5, tolerance=0.2) {
  translate([0,10,0])ext2040(l=l, teeth = [teeth[0],teeth[1],teeth[2], 0,0,teeth[7]]);
  translate([0,-10,0])ext2040(l=l, teeth = [0,0,teeth[3],teeth[4],teeth[5], teeth[6]]);
}
module ext2040(l=20, teeth = [1, 1, 1, 1, 1, 1], depth=1.5, tolerance=0.2) {
  translate([10,0,0])ext2020(l=l, teeth = [teeth[2],0,teeth[1],teeth[3]]);
  translate([-10,0,0])ext2020(l=l, teeth = [0,teeth[5],teeth[0],teeth[4]]);
}
module ext2040(l=20, teeth = [1, 1, 1, 1, 1, 1], depth=1.5, tolerance=0.2) {
  translate([10,0,0])ext2020(l=l, teeth = [teeth[2],0,teeth[1],teeth[3]]);
  translate([-10,0,0])ext2020(l=l, teeth = [0,teeth[5],teeth[0],teeth[4]]);
}
module ext2020(l=20, teeth = [1, 1, 1, 1], depth=1.5, tolerance=0.2) {
  scale([1,1,1])translate([0,0,l/2])
  difference(){
    cube([20+tolerance,20+tolerance,l], center=true);
    scale([1,1,1]) {
        if (teeth[0] == 1)
        translate([10-((depth+tolerance)/2)+tolerance,0,0])cube([depth+tolerance,5.68-tolerance,l], center=true);
        if (teeth[1] == 1)
        translate([-10+((depth+tolerance)/2)-tolerance,0,0])cube([depth+tolerance,5.68-tolerance,l], center=true);
    }
    scale([1,1,1]) {
        if (teeth[2] == 1)
        translate([0,10-((depth+tolerance)/2)+tolerance,0])cube([5.68-tolerance,depth+tolerance,l], center=true);
        if (teeth[3] == 1)
        translate([0,-10+((depth+tolerance)/2)-tolerance,0])cube([5.68-tolerance,depth+tolerance,l], center=true);
      }
  }
}

module inv_ext2020(l=20, teeth = [1, 1, 1, 1], depth=1.5, tolerance=0.2, thick=3, hole=0, support=[1,1], layer_height=0.3) {
{
    difference() {
      translate([0,0,l/2])
        cube([20+thick,20+thick,l], center=true);
      translate([0,0,thick])ext2020(l=l-thick, teeth=teeth, tolerance=tolerance, depth=depth);
      #translate([0, l+15+layer_height,(l/2)+(hole/2)]) rotate([90,0,0])cylinder(d=hole, h=25+thick*2);
      }
    }
}
