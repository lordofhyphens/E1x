use <inc/functions.scad>
mirror([1,0,0])
translate([-33,-20-15,-plate[2]])
{
  rotate([0,0,90])linear_extrude(height=15+7-9.4)projection(cut=false)import("T1_extruder_v0.9.stl");
  translate([0,0,20-9.4])
    rotate([0,0,90])import("T1_extruder_v0.9.stl");
}

tolerance=0.3;
mount_type="wades"; // wades, prusa, or rework. Rework needs a compact-version to fit properly.
measured_rail_edge_to_edge=58.82;
bearing_to_vslot=10.10;
fudge_distance=-5;
wheel_separation = 39.7;// 10+(2*bearing_to_vslot)-fudge_distance;
//wheel_separation = rail_separation+(2*bearing_to_vslot)+x_rod_thickness;
shift_in=3.5;
standoff = (mount_type == "rework" ? true : false); // standoff shouldn't be necessary for wades or prusa-type
rail_size = 20;
wheel_offset = 20;
wheel_od = 25;
extruder_x = 35;
extruder_z = 52;
wheels = 4;
rework_x_sep = 23;
rework_y_sep = 23;
wades_x_sep = 50;
wades_y_sep = 30;
prusa_y_sep = 0;
plate_x = (wheel_od*2 + 4 > extruder_x ? wheel_od*2 + 4 : extruder_x);
plate_y = wheel_separation + 10;
plate = [extruder_x + 20, plate_y, 4];
echo("Tolerance: ", tolerance);
if (standoff) 
  translate([0,100,0])
  rotate([0,0,90])
  standoff();
module standoff() {
  difference() {
    translate([0,0,7/2])
    translate([0,  0, plate[1]/2 - extruder_z/2,0])
      roundcube([extruder_x-2,extruder_z,7], center=true);

    translate([plate[0]/2 - extruder_x/2, plate[1]/2 - extruder_z/2,0])
    translate([-10, -22,-5])cylinder(r=8, h=20);
    translate([plate[0]/2 - extruder_x/2, plate[1]/2 - extruder_z/2,0])
      translate([-10,0,5]) {
      for (j = [1,-1]) // extruder reworking holes
        for (i = [1,-1])
          translate([i*rework_x_sep/2, j*rework_y_sep/2,0])
          {
            translate([0,-21.5,0]) {
              #translate([0,0,5])mirror([0,0,1])boltHole(size=4,length=15, $fs=0.1);
            } 
          }
      }

  }
  }

mirror([0,0,1])xcarriage(plate=plate,mountpoints=1, wheels=wheels);
module xcarriage(plate, mountpoints=1, wheels=4, sepwidth=15.16, shift=[], padding=35) {
  scaled_plate = [plate[0]*(mountpoints-1) + (sepwidth*(mountpoints))+padding, plate[1], plate[2]];

  difference() {
  union() 
  {
    translate([0,-10,scaled_plate[2]/2])roundcube(scaled_plate, percent=5, center=true);
    translate([0,0,scaled_plate[2]/2])roundcube(scaled_plate, center=true);
  }

    // gaps for attachment points
    *for (j = [scaled_plate[0]/2 - 6, -scaled_plate[0]/2 + 6])
      for (i = [10,10])
        translate([j,i,0])
          #hull() {
            translate([-(3 - 3/2)/2, -(10-3/2)/2, 0])
            cylinder(d=3/2, h =50, center=true);
            translate([-(3 - 3/2)/2, (10-3/2)/2, 0])
            cylinder(d=3/2, h =50, center=true);
            translate([(3 - 3/2)/2, -(10-3/2)/2, 0])
            cylinder(d=3/2, h =50, center=true);
            translate([(3 - 3/2)/2, (10-3/2)/2,0])
            cylinder(d=3/2, h =50, center=true);
          }
    translate([0,fudge_distance/2,0])
    { // holes for v wheel mounting
      for (i = [1 , -1])

        if (i == 1 || wheels == 4) {
          color("blue")translate([0,i*wheel_separation/2, 0]) 
          {
            #translate([-scaled_plate[0]/2 + M5nut, 0,0])
            {
              cylinder(r=M5/2 + tolerance, h=scaled_plate[2],  $fs=0.1);
              *cylinder(r=M5nut/2 + tolerance*2, h=M5nutThickness,  $fn=6);
            }
            #translate([scaled_plate[0]/2 - M5nut,0,0])
            {
              cylinder(r=M5/2 + tolerance*2, h=scaled_plate[2],  $fs=0.1);
              *cylinder(r=M5nut/2 + tolerance*2, h=M5nutThickness,  $fn=6);
            }
          }
        } else {
          color("blue")translate([0,i*wheel_separation/2, 0]) 
          {
            cylinder(r=M5/2 + tolerance*2, h=scaled_plate[2],  $fs=0.1);
            *cylinder(r=M5nut/2 + tolerance*2, h=M5nutThickness,  $fn=6);
          }
        }
    }
    for (mnt = [0 : mountpoints-1]) 
      *translate([(((mountpoints-1)*plate[0])/(mountpoints+1))+(sepwidth*(mountpoints-1))/2,0, 0])
        translate([-(mnt*plate[1])/2-(sepwidth*mnt),shift[mnt],0])
        {
          #translate([0,-5,0])cylinder(r=8, h=20);
          if (mount_type == "rework")
          {
            translate([0,-5,0])
              for (j = [1,-1]) // extruder reworking holes
                for (i = [1,-1])
                  translate([i*rework_x_sep/2, j*rework_y_sep/2,0])
                    #translate([0,0,3.8])mirror([0,0,1])boltHole(size=4,length=7);
          }
          else if (mount_type == "prusa")
          {
            translate([0,-17.5,0])
              for (j = [1,-1]) // extruder prusaing holes
                for (i = [1,-1])
                  translate([scaled_plate[0]/2 + i*prusa_x_sep/2, scaled_plate[1]/2 + j*prusa_y_sep/2,0])
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
                  translate([scaled_plate[0]/2 + i*wades_x_sep/2, scaled_plate[1]/2 + j*wades_y_sep/2,0])
                  {
                    if (standoff)
                    {
                      translate([0,-21.5,0]) {
                        #translate([0,0,5])mirror([0,0,1])boltHole(size=4,length=15, $fs=0.1);
                      }
                    } 
                    else  
                    {
                      #translate([0,0,5])mirror([0,0,1])boltHole(size=4,length=7);
                    }
                  }
          }
          else { }
        }
  }
}
include <inc/configuration.scad>
include<inc/metric.scad>
include<MCAD/nuts_and_bolts.scad> // MCAD library
include<inc/extrusions.scad>
include<inc/vslot.scad>
