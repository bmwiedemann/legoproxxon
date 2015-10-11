// CSG.scad - Basic example of CSG usage

cw=2;  // clamp width
wr=cw+58/2;    // wheel radius
wh=wr/18; // wheel height
ch=13+wh;  // clamp height
chs=ch/12;  // clamp holder size
lsc=4.85;  // legocross size
numteeth=round(360*wr/170);
toothf=360/numteeth; // angle per tooth
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
            linear_extrude(height = wh, scale = 0.4) {
                //circle(wr*0.6, center = true);
            }
            for (alpha = [0:numteeth])
              rotate(alpha*toothf,0,0)
                translate([wr*0.94,0,0])
                    tooth();
        }
        legocross();
        translate([wr*0.80,0,0]) {
            cylinder(h=2*wh, r=wr/5.5, center=true);
        }
    }
}


module legocross() {
    union() {
        cube([lsc/3,lsc,10], center=true);
        cube([lsc,lsc/3,10], center=true);
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
        rotate(45+alpha*360/numclamps)
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

// Written 2015 by Bernhard M. Wiedemann <bernhard+scad lsmod de>

// re-used from parametric_lego_rack_gear by buffington
module tooth() {
  tooth_base_width    = 2.3;
  tooth_tip_width     = 0.87;
  tooth_height        = 2.06;
  tooth_tip_radius    = 0.15;
  gap_width           = 0.884;
  tooth_width = wh; //(brick_width * width_in_studs);

  x_a = -((tooth_tip_width/2) - tooth_tip_radius);
  x_b = (tooth_tip_width/2) - tooth_tip_radius;
  rotate([90,0,0])
  rotate([0,90,0])
  translate([0,0,(gap_width+tooth_base_width)/2]){
      hull() {
        translate([x_a,0,tooth_height]) rotate([90,0,0]) cylinder(r=tooth_tip_radius,   h=tooth_width, center=true);
        translate([x_b,0,tooth_height]) rotate([90,0,0]) cylinder(r=tooth_tip_radius,   h=tooth_width, center=true);
        translate([0,0,0])              rotate([90,0,0]) cylinder(r=tooth_base_width/2, h=tooth_width, center=true);
      }
  }
}