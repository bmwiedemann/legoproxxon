// CSG.scad - Basic example of CSG usage

cw=3;  // clamp width
wr=cw+58/2;    // wheel radius
wh=1.5; // wheel height
hubheight=1; // in addition to wh
chs=1.4;  // clamp holder size
ch=8+hubheight+chs*1.4+wh;  // clamp height
cpitch=1.03; // diametral pitch
rim=3;
numteeth=round((wr+rim)*2*cpitch);
wro=numteeth/(2*cpitch);
numclamps=4;
geartolerance=0.2;
debug=false;


// Global resolution
$fa = 5;    // Don't generate larger angles than 5 degrees
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
//$fn = 100;

use <MCAD/involute_gears.scad>

union() {
    wheelObject();
    clamps();
}

module wheelObject() {
    color("Lime")
    difference() {
        union() {
            biggear();
        }
    }
}

module biggear() {
    gear (
        number_of_teeth=numteeth,
        diametral_pitch=cpitch,
        pressure_angle=20,
        clearance=geartolerance,
        backlash=geartolerance,
        gear_thickness=wh,
        rim_thickness=wh+1,
        rim_width=rim,
        hub_thickness=wh+hubheight,
        hub_diameter=30,
        bore_diameter=15,
        circles=numclamps,
        twist=0,
        involute_facets=0,
        flat=false);
}

module clamps()
{
    for (alpha = [1:numclamps]) {
        rotate((0.5+alpha)*360/numclamps)
            translate([wro-rim-cw/4, 0, ch/2]) {
                clamp();
            }
    }
}
module clamp()
{
    union() {
        cube([cw/2,cw,ch], center=true);
        translate([-cw/4,0, ch/2-chs*0.71]) {
            color("Red")
            rotate([0,45,0])
              cube([chs, cw, chs], center=true);
        }
    }
}

// Written 2015 by Bernhard M. Wiedemann <bernhard+scad lsmod de>

