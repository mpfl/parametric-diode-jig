/* [Basic] */

// The distance between the centres of the two soldering holes
span = 7.5;

// The height of the jig
height = 30;

/* [Fine tuning] */

// Tolerances
tolerance = 0.2; // Increase all diode diameters by this much because 3D printers are analogue

// Diode body diameter
diodeBodyDiameter = 2.76;

// Diode body length
diodeBodyLength = 3.14;

// Diode leg diameter
diodeLegDiameter = 0.5;

// Let's smoooooth those corners
cornerRadius = 1.5;

// Render quality - Thingiverse is unhappy if you put this too high
quality = 60;

/* [ Hidden ] */

// The acutal width of the jig, taking diode leg diameter into account
width = span - 2 * diodeLegDiameter;

$fn = quality;

print_part();

module print_part() {
    difference () {
        jigBody();
        diodeCutout();
    }
}

module diodeCutout() {
    translate([0,0,height - (diodeLegDiameter + tolerance)/2 + 0.0001]) {
        cube([diodeBodyLength, diodeBodyDiameter + tolerance, diodeBodyDiameter + tolerance], center = true);
        cube([span, diodeLegDiameter + tolerance, diodeLegDiameter + tolerance], center = true);
    }
}

module jigBody() {
    linear_extrude(height)
        crossSection();
}

module crossSection() {
    hull() {
        translate([-(width/2 - cornerRadius), -(width/2 - cornerRadius)])
            circle(r=cornerRadius);
        translate([(width/2 - cornerRadius), -(width/2 - cornerRadius)])
            circle(r=cornerRadius);
        translate([-(width/2 - cornerRadius), (width/2 - cornerRadius)])
            circle(r=cornerRadius);
        translate([(width/2 - cornerRadius), (width/2 - cornerRadius)])
            circle(r=cornerRadius);
    }
}