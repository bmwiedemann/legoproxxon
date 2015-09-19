// CSG.scad - Basic example of CSG usage

wr=17;    // wheel radius
wh=wr/10; // wheel height
cw=wh;  // clamp width
ch=7;  // clamp height
chs=0.9;  // clamp holder size
lsc=0.5;  // legocross size
numclamps=4;
debug=false;

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees


union() {
    wheelObject();
    clamps();
}

module wheelObject() {
    color("Lime")
    difference() {
        union() {
            cylinder(h=wh, r=wr, center=true);
            linear_extrude(height = wh, scale = 0.25) {
                circle(wr/3, center = true);
            }
        }
        legocross();
        translate([wr*0.6,0,0]) {
            cylinder(h=2*wh, r=wr/6, center=true);
        }
    }
}


module legocross() {
    union() {
        cube([lsc,3*lsc,10], center=true);
        cube([3*lsc,lsc,10], center=true);
    }
}

if(debug) {
    translate([10,0,20]) {
        legocross();
    }
}

module clamps()
{
    for (alpha = [1:numclamps]) {
        rotate(alpha*360/numclamps) 
            translate([wr-cw/4, 0, ch/2-wh/2]) {
                clamp();
            }
    }
}
module clamp()
{
    union() {
        cube([cw/2,cw,ch], center=true);
        translate([-cw/4,0, ch/2-chs*0.5]) {
            color("Red")
            cube([chs, cw, chs], center=true);
        }
    }
}

// Written by Bernhard M. Wiedemann <bernhard+scad lsmod de>
//

