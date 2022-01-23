/* [Basic] */

// The distance between the centres of the two soldering holes
span = 10;

// The height of the jig
height = 30;

/* [Fine tuning] */
 
// Diode body diameter
diodeBodyDiameter = 2.76;

// Diode body length
diodeBodyLength = 3.14;

// Diode leg diameter
diodeLegDiameter = 0.5;

// Let's smoooooth those corners
cornerRadius = 1;

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
    translate([width/2-diodeBodyDiameter/2,width/2,height])
        rotate([0,90,0]) {
            cylinder(d = diodeBodyDiameter, h = diodeBodyLength);
            translate([0,0,diodeBodyDiameter/2-width/2])
                cylinder(d = diodeLegDiameter, h = span);
        }
}

module jigBody() {
    linear_extrude(height)
        crossSection();
}

module crossSection() {
    hull() {
        translate([cornerRadius,cornerRadius])
            circle(r=cornerRadius);
        translate([width - cornerRadius, cornerRadius])
            circle(r=cornerRadius);
        translate([cornerRadius, width - cornerRadius])
            circle(r=cornerRadius);
        translate([width - cornerRadius, width - cornerRadius])
            circle(r=cornerRadius);
    }
}