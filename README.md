# E1x
E1x Printer Files - "V-Slot Lulzbot special"

BOM located here - http://goo.gl/RWq3ZI

Wiki page (with some assembly instructions) - http://reprap.org/wiki/E1x-V

If using the 300x300 Y Carriage for the TAZ and the accompanying borosilicate glass plate, these corner pieces are recommended: 
[Lulzbot Y Corner](http://devel.lulzbot.com/TAZ/Juniper/production_parts/printed_parts/bed_corner/)

Otherwise, edit SCAD/lulz-cornermount to suit the size of your printbed.
The STL is pre-sized for a 12"x12" piece.

This variant employs Vslot on all 3 axes. This arrangement is
experimental, it may take a few re-prints of parts to get things to line up
(particularly the Y axis parts with the printbed).

The X motor and idler endsshould be printed at 0.2mm layer height or lower.  If
using slic3r or another program capable of doing so, use 0.1mm layer heights
between 20.5mm and 21.1mm

With a 300mm bed, the printer is wide enough to home completely off of the bed. 

# Extra Hardware Required
* [6mm Eccentric Spacers](https://openbuildspartstore.com/eccentric-spacer/)
    * 6 required
* [V-Wheels](https://openbuildspartstore.com/solid-v-wheel/)
* [V-Slot Gantry Plate](https://openbuildspartstore.com/v-slot-gantry-plate-universal/)
    * Used for the X Carriage. 
    * Used with [this print](https://www.thingiverse.com/thing:1902194)
* [Aluminum Spacers (6mm thick)](https://openbuildspartstore.com/aluminum-spacers-10-pack/)x10
* T5 or T8 leadscrew with brass or delrin nut
    * T8x8 works, as does T8x2
    * Needs to be around 400mm long
* Either use integrated leadscrews for Z motors (430mm if integrated) or use printed couplers with pipe clamps. 

# Recommended Components
* Use a higher-current NEMA23 motor and external driver for the bed. 
