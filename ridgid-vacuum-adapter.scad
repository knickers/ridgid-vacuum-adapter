$fn = 24;
thickness = 2;//3;

module curve() {
	inner = 114;
	outer = inner + thickness;
	half = outer/2;
	height = 5;//43;
	offset = 87;

	translate([0, half, 0])
		difference() {
			cylinder(d=outer, h=height, $fn=$fn*2);
			translate([0, 0, -1])
				cylinder(d=inner, h=height+2, $fn=$fn*2);
			translate([-half-1, half-offset, -1])
				cube([outer+2, outer, height+2]);
		}
}

module tab(hole, wall) {
	size = hole + wall;
	half = size / 2;

	difference() {
		union() {
			cylinder(d=size, h=thickness);

			translate([-half, -half, 0])
				cube([half, size, thickness]);
		}
		translate([0, 0, -1])
			cylinder(d=hole, h=thickness+2, $fn=$fn/2);
	}
}

module tabs() {
	distance = 85.5;
	half = distance / 2;
	hole = 3.6; // 6-32 screw = 0.138 in = 3.5052 mm
	wall = 3;//10;

	translate([-half, 0, 0])
		mirror([1, 0, 0])
			tab(hole, wall);

	translate([half, 0, 0])
		tab(hole, wall);

	size = hole + wall;

	translate([-half+size/2, -size/2, 0])
		cube([distance-size, size, thickness]);
}

curve();

translate([0, -10, 0])
	tabs();
