
legoproxxon.gcode: legoproxxon.stl
	slic3r --solid-infill-below-area 25 --fill-density 15 --gui-mode on legoproxxon.stl

legoproxxon.stl: legoproxxon.scad
	openscad -o $@ $<

