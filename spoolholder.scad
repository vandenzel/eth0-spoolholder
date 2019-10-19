$fn = 90;

/*
 * Spoolholder for the embroidery machines at Eth0 Autumn 2019
 * 
 * Alex van Denzel 2019 CC-BY-SA-3.0
 * Use for fun and profit. Buy me a beer[1] when the profit affords it.
 *
 * [1] Kompaan Bloedbroeder is a nice example. 
 */
 
// sizes in mm

top_diameter = 20;
bottom_diameter = 32;
total_height = 40;
cap_height = 10;
wall_thickness  = 1.5;
spline_diameter = 3; // at bottom, will scale at top.
hole_diameter = 6;
slot_width = 2;

module spoolholder() {
    
    module shell() {
        linear_extrude( height = total_height, scale = top_diameter / bottom_diameter ) { 
            union() {
                difference() {
                    circle( d = bottom_diameter );
                    circle( d = bottom_diameter - ( 2 * wall_thickness ) );
                }
                for ( i = [ 0 : 7 ] ) {
                    rotate( [ 0, 0, ( i + .5 ) * 360 / 8 ] )
                        translate( [ ( bottom_diameter - wall_thickness ) / 2, 0, 0 ] )
                            circle( d = spline_diameter );
                }
            }
        }
    }
        
    module cap() {
        difference() {
            intersection() {
                linear_extrude( height = total_height, scale = top_diameter / bottom_diameter )
                    circle( d = bottom_diameter );
                translate( [ 0, 0, total_height - cap_height ] ) 
                    linear_extrude( height = cap_height )
                        circle( d = bottom_diameter );
            }
            cylinder( d = hole_diameter, h = total_height );
        }
    }
    

    difference() {
        shell();
        for ( i = [ 0 : 3 ] ) rotate( [ 0, 0, i * 360/8 ] )
            translate( [ -slot_width / 2, -bottom_diameter / 2, 0 ] ) 
                cube( [ slot_width, bottom_diameter, total_height - cap_height ] );
    }
    cap();
}

spoolholder();

