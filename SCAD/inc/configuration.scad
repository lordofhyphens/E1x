// Copyright (C) 2012 t00tie
// Adapto is licensed under the Creative Commons - GNU GPL license.
// http://creativecommons.org/licenses/GPL/2.0/

//==========================================================================//
// Configuration file for Adapto OpenSCAD files                             //
// Scroll past the definition section to change basic and advanced settings //
//==========================================================================//

//====================//
// Definition Section //
//====================//
// Frame and Walls
// frameX and frameY are the dimensions of the frame material when viewed on end(the end of an extrusion looks roughly like an X)
// frameX is the width of the frame material
// frameY is the height of the frame material
//   x
//  [ ]y
// these are used to find offsets for screw placing so screws meet the (slot in the) middle of the frame
frameX=20;// width of the frame material(alu, wood etc.)
frameY=20;// height of the frame material

// Print the hole_calibration.scad object to dial in the next 6 settings
// Google found http://www.fairburyfastener.com/xdims_metric_nuts.htm
M8=8.4;// diameter of M8 threaded rod
M5=5.3;// diameter of M5 threaded rod
M3=3.4;// diameter of M3 threaded rod
M8nut=13;// diameter of M8 nut flat to flat
M5nut=8;// diameter of M5 nut flat to flat
M3nut=5.6;// diameter of M3 nut flat to flat

M8nutThickness=6.8;// thickness of a standard M8 nut(nylock is 8mm)
M5nutThickness=4.7;// thickness of a standard M5 nut(nylock is 5mm)
M3nutThickness=2.4;// thickness of a standard M3 nut

// Acme Linear Screw and Nut
ACME14=6.5;// diameter of 1/4 inch ACME threaded rod in mm
ACME14nut=12.8;// diameter of ACME 1/4 inch nut flat to flat in mm
ACME14nutThickness=6.5;// thickness of ACME 1/4 inch nut in mm


// Linear Bearings
// format is IDxODxL
lm8uu=[8, 15, 24];
lm10uu=[10, 19, 29];
lm10luu=[10, 19, 55];
lm12uu=[12, 21, 30];

//rotary bearings
// format is IDxODxL
xx623=[3, 10, 4];
MF204=[4, 10, 4];
MF126=[6, 12, 4];
rotaryBearing=xx623;// for readability(can be changed if other bearings are used

//====================//
// Basic Config Items //
//====================//
smoothRod=8;				// diameter of smooth rods in mm
linearBearing=lm8uu;	// change this to the linear bearing you are using from the definitions section
zRod=M5;				// change this to the z threaded rod you are using from the definitions section
zRodnut=M5nut;		// change this to the z nut you are using from the definitions section
zRodnutThickness=M5nutThickness;	// change this to the z nut thickness you are using from the definitions section


//=======================//
// Advanced Config Items //
//=======================//
$fn=90;		// default resolution for parts, decrease if part compiling or stl/gcode is unmanageable
thickness=5;		// thickness of walls etc. in parts
pullyDiameter=12.2;	// GT2-20 toothed section diameter

// center of Z drive rod, relative to Z extrusion center
shaft_offset=[47, 15];
x_rod_thickness=20;
length_to_hole=43;
bearing_to_vslot=9.63;
belt_z_space = 16;
rail_separation = belt_z_space + x_rod_thickness + 2; // minimum space between the top and bottom 
tolerance=0.2;
