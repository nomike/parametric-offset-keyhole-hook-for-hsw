include <hws_insert_util.scad>

/* 
Parametric Offset Keyhole Hook for HSW

Copyright 2024 nomike[AT]nomike[DOT]com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/*
This hook allows you to mount objects with those common keyholes on a HSW. It creates an insert, whith a hook to which you can attach such a hole. As the distnace between two keyholes is not always a multiple of the distance between two adjecant Honeycomb fields, it calculates how much this is off and offsets the hook accordingly.


     |--|    keyhole_small_diameter
  
      xx   
     x  x  
     x  x  
     x  x  
     x  x  
    x    x 
   x      x
   x      x
    x    x 
     xxxx  
  
   |------|  keyhole_large_diameter
*/
/* [Setup Parameters] */
$fa = 8;
$fs = 0.25;

/* [Options] */
tolerance = 0;
decoration = false;

module insert_plug_adv(structure)
{
    for (y_pos = [0:len(structure) - 1])
    {
        for (x_pos = [0:len(structure[y_pos]) - 1])
        {
            if (structure[y_pos][x_pos] != 0)
            {
                _draw_insert(structure, x_pos, y_pos, tolerance, decoration);
            }
        }
    }
}


structure = [[2]];

total_width = 278.5; // Measure the exact distance  

keyhole_small_diameter = 5;
keyhole_small_width = 1.5;
keyhole_large_diameter = 10;
keyhole_large_width = 2.0;

hsw_horizontal_distance_unit = 40.88; // Constant, see documentation of HSW


width_hsw_horizontal_distance_unit = round(total_width / hsw_horizontal_distance_unit);

_gap = total_width - (width_hsw_horizontal_distance_unit * hsw_horizontal_distance_unit);

gap = _gap;

echo("--> hsw_horizontal_distance_unit: ", hsw_horizontal_distance_unit);
echo("--> total_width: ", total_width);
echo("--> width_hsw_horizontal_distance_unit: ", width_hsw_horizontal_distance_unit);
echo("--> _GAP: ", _gap);
echo("--> GAP: ", gap);

union() {
    insert_plug_adv(structure);
    translate([gap/2, 0, 0]) union() {
        translate([0, 0, -keyhole_small_width]) cylinder(d=keyhole_small_diameter, h=keyhole_small_width);
        translate([0, 0, 0 - keyhole_small_width - keyhole_large_width]) cylinder(d=keyhole_large_diameter, h=keyhole_large_width);
    }
}
