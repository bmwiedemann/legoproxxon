
legoproxxon.gcode: legoproxxon.stl
	slic3r --solid-infill-below-area 25 --fill-density 15 --gui-mode on legoproxxon.stl

legoproxxon.stl: legoproxxon.scad
	openscad -o $@ $<

legoproxxon.png: legoproxxon.scad
	openscad --projection=o --imgsize=2500,2500 --camera=0,0,200,0,0,0 -o $@ $<
