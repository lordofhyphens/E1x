use<MCAD/nuts_and_bolts.scad>
holes = [[142,142],[147,157],[157,157],[157,147] ];



//spreader=[0.4+12*25.4,0.4+9*25.4,3];
spreader=[0,0,0];
glass=[1.5+300,1.5+300,3.08];
cork=[12*25.4,12*25.4,3];
screws_offset=(5/64)*25.4 + 3;
heater=[225,225,1];
cork_plane = [cork[0],cork[1],cork[2]+screws_offset];

*color("red")translate([0,0,heater[2]/2 + cork_plane[2]])cube(heater,center=true);
*color("blue")translate([0,0,heater[2]+spreader[2]/2 + cork_plane[2]])cube(spreader,center=true);
*color("yellow")translate([0,0,heater[2]+glass[2]/2+ spreader[2] + cork_plane[2]])cube(glass,center=true);

bracket = [162*2,162*2,12];
cutout=1.13 ;

// corner mounting holes
difference() {
  translate([0,0,bracket[2]/2])cube(bracket,center=true);
for (k = [1,-1])
  for (j = [1,-1]) 
    for (i = holes) {
      mirror([0,0,1])translate([k*i[0],j*i[1],-bracket[2]+9.5])boltHole(size=4, length=bracket[2]);
      mirror([0,0,1])translate([k*i[0],j*i[1],-bracket[2]+7])boltHole(size=4, length=bracket[2]);
      mirror([0,0,1])translate([k*i[0],j*i[1],-bracket[2]+5])boltHole(size=4, length=bracket[2]);
      mirror([0,0,1])translate([k*i[0],j*i[1],-bracket[2]+3])boltHole(size=4, length=bracket[2]);
//      *cylinder(r=3.2/2, h=bracket[2]+5);
    }
color("red")translate([0,0,heater[2]/2 + cork_plane[2]])cube(heater,center=true);
color("blue")translate([0,0,heater[2]+spreader[2]/2 + cork_plane[2]])cube(spreader,center=true);
color("yellow")translate([0,0,heater[2]+glass[2]/2+ spreader[2] + cork_plane[2]])cube(glass,center=true);
color("green") translate([0,0,bracket[2]/2])cube([bracket[0]/cutout,bracket[1],bracket[2]],center=true);
color("green") translate([0,0,bracket[2]/2])cube([bracket[0],bracket[1]/cutout,bracket[2]],center=true);

}
