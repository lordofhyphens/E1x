// Needs the SCAD from https://www.youmagine.com/designs/parametric-timing-belt-generator
// to compile properly.
mount_type="rework"; // wades, prusa, or rework. Rework needs a compact-version to fit properly.

distance_to_belt_center = 13;
translate([plate[0]/2-extruder_x/2,plate[1]/2,7])
  difference()
  {
    translate([0,-4,0])cube([extruder_x, 13,distance_to_belt_center+7]);
    translate([0,3,distance_to_belt_center]) { scale([1,1,1.4])
      mirror([0,1,0])belting(print_layout="straight", tooth_profile="GT2_2mm", belt_length=extruder_x);
      translate([extruder_x/2 - 3,-5,0])cube([6, 5,distance_to_belt_center]);
      translate([0,-7.5,0])cube([extruder_x, 3,distance_to_belt_center]);
    }
  }

standoff = (mount_type == "rework" ? true : false); // standoff shouldn't be necessary for wades or prusa-type
rail_separation = 41;
rail_size = 20;
wheel_offset = 20;
wheel_od = 25;

extruder_x = 35;
extruder_z = 52;

rework_x_sep = 23;
rework_y_sep = 23;
wades_x_sep = 50;
wades_y_sep = 0;
prusa_x_sep = 30;
prusa_y_sep = 0;

plate_x = (wheel_od*2 + 4 > extruder_x ? wheel_od*2 + 4 : extruder_x);
plate_y = (rail_size + rail_separation + wheel_offset * 2 > extruder_z ? rail_size+ rail_separation + wheel_offset * 2 : extruder_z);
plate = [extruder_x + 20, plate_y, 7];

if (standoff) 
  translate([plate[0]*2,0,0])
  difference() {
      translate([plate[0]/2 - extruder_x/2, plate[1]/2 - extruder_z/2,0])
      cube([extruder_x,extruder_z,7]);
      translate([plate[0]/2 - extruder_x/2, plate[1]/2 - extruder_z/2,0])
      translate([-10,-10,5])
        for (j = [1,-1]) // extruder reworking holes
          for (i = [1,-1])
            translate([plate[0]/2 + i*rework_x_sep/2, plate[1]/2 + j*rework_y_sep/2,0])
            {
              translate([0,-21.5,0]) {
                translate([0,0,5])mirror([0,0,1])boltHole(size=4,length=15, $fs=0.1);
              } 
            }

  }
difference() {
    cube(plate);
    translate([0,10,0])
    { // holes for v wheel mounting
      translate([0,plate[1] -(2*wheel_offset+rail_separation+rail_size-0.55), 0]) 
      {
        translate([plate[0]/2 - (2+ wheel_od/2), 0,0])
        {
          cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
          nutHole(size=5);
        }
        translate([plate[0]/2 + 2+wheel_od/2,0,0])
        {
          cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
          nutHole(size=5);
        }
      }
      translate([0,plate[1] - wheel_offset, 0]) 
      {
        translate([plate[0]/2 - (2+ wheel_od/2), 0,0])
        {
          cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
          nutHole(size=5);
        }
        translate([plate[0]/2 + 2+wheel_od/2,0,0])
        {
          cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
          nutHole(size=5);
        }
      }
    }
  if (mount_type == "rework")
  {
    translate([0,-19,0])
      for (j = [1,-1]) // extruder reworking holes
        for (i = [1,-1])
          translate([plate[0]/2 + i*rework_x_sep/2, plate[1]/2 + j*rework_y_sep/2,0])
              translate([0,0,3.8])mirror([0,0,1])boltHole(size=4,length=7);
  }
  else if (mount_type == "prusa")
  {
    translate([0,-17.5,0])
    for (j = [1,-1]) // extruder prusaing holes
      for (i = [1,-1])
        translate([plate[0]/2 + i*prusa_x_sep/2, plate[1]/2 + j*prusa_y_sep/2,0])
        {
          if (standoff)
          {
            translate([0,-21.5,0]) {
              translate([0,0,5])mirror([0,0,1])boltHole(size=3,length=15, $fs=0.1);
            }
          } 
          else  
          {
            translate([0,0,5])mirror([0,0,1])boltHole(size=3,length=17);
          }
        }
  }
  else if (mount_type == "wades")
  { 
    translate([0,-17.5,0])
    for (j = [1,-1]) // extruder wadesing holes
      for (i = [1,-1])
        translate([plate[0]/2 + i*wades_x_sep/2, plate[1]/2 + j*wades_y_sep/2,0])
        {
          if (standoff)
          {
            translate([0,-21.5,0]) {
              translate([0,0,5])mirror([0,0,1])boltHole(size=4,length=15, $fs=0.1);
            }
          } 
          else  
          {
            translate([0,0,5])mirror([0,0,1])boltHole(size=4,length=7);
          }
        }
  }
  else { }
}

include<inc/metric.scad>
include<MCAD/nuts_and_bolts.scad> // MCAD library
use<Belt_Generator.scad> // https://www.youmagine.com/designs/parametric-timing-belt-generator
