length = 57;
width = 36;
wall_thickness = 4;
base_wall_thickness = 1.5;
board_overlap = 2;
height_above = 12+wall_thickness/2;
height_below = 7+wall_thickness/2;
board_thickness = 1.5;
micro_usb_offset = 2;
micro_usb_width = 7.8 + 1;
micro_usb_height = 3 + 1;
sma_length_offset = 37;
sma_diameter = 6.2 + 1;
sma_flat_diameter = 5.7;
sma_flat_offset = 5.7+0.5-6.2/2;
sma_height_offset = sma_diameter / 2;
depth = height_above + height_below + board_thickness;

union(){
	translate([depth/2+wall_thickness/4,0,-length/2+(wall_thickness-base_wall_thickness)])
		cube([wall_thickness/2,width+wall_thickness*2,wall_thickness*2], center=true);
	translate([-depth/2-wall_thickness/4,0,-base_wall_thickness/2])
		cube([wall_thickness/2,width+wall_thickness*2,length+base_wall_thickness], center=true);
	translate([0,width/2+wall_thickness/2,0])
		difference(){
			union(){
				cube([depth, wall_thickness, length], center=true);
				translate([
					depth/2 - height_above - board_overlap/2,
					-board_overlap*1.25,
				0])
					union(){
						translate([board_overlap + board_thickness/2 + 0.5,0,0])
							cube([board_overlap, board_overlap, length],
								center=true);
						translate([ - board_thickness/2 - 0.5,0,0])
							cube([board_overlap, board_overlap, length],
								center=true);
					}
			}
			rotate([90,00,0])
				translate([depth/2 - height_above - board_thickness/2-sma_height_offset,-length/2+sma_length_offset,0])
					difference(){
						cylinder(h=wall_thickness*3,r=sma_diameter/2,$fn=32,center=true);
						translate([sma_flat_offset+sma_flat_diameter/2,0,0])
							cube([sma_flat_diameter,sma_flat_diameter,sma_flat_diameter*2], center=true);
					}
		}
	translate([0,-width/2-wall_thickness/2,0])
		union(){
			cube([depth, wall_thickness, length], center=true);
			translate([
				depth/2 - height_above - board_overlap/2,
				board_overlap*1.25,
			0])
				union(){
					translate([board_overlap + board_thickness/2 + 0.5,0,0])
						cube([board_overlap, board_overlap, length],
							center=true);
					translate([ - board_thickness/2 - 0.5,0,0])
						cube([board_overlap, board_overlap, length],
							center=true);
				}
		}
	translate([0,0,-length/2 - base_wall_thickness/2])
		difference(){
			cube([depth, width + wall_thickness*2, base_wall_thickness], center=true);
			translate([
				depth/2 - height_above - board_thickness/2 - micro_usb_height/2 + 0.5,
				width/2 - micro_usb_offset - micro_usb_width /2,
				0]
			)
				cube([micro_usb_height, micro_usb_width, wall_thickness * 2], center=true);
		}
}