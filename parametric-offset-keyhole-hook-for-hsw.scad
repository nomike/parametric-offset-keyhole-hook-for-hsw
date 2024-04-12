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
This hook allows you to mount objects with those common keyholes on a HSW.
It creates an insert, whith a hook to which you can attach such a hole.
As the distnace between two keyholes is not always a multiple of the distance
between two adjecant Honeycomb fields, it calculates how much this is off and
offsets the hook accordingly.

#### Configuring

1.  Measure the distance between the centers of the keyholes with a ruler and
    put it in `total_width`.

In most cases this should be enough.

However, if your keyhole doesn't look standard, you can do further adjustements:

2. Measure the smaller diameter of the keyhole with a caliper and put it in
    `keyhole_small_diameter`.
3. Measure the larger diameter of the keyhole with a caliper and put it in
    `keyhole_large_diameter`.
4. `keyhole_small_width` corresponds to the thickness of the material the
    keyhole is in. I'm hanging a small parts magazine to my HSW and the metal
    sheet of it's casing is 1.5mm thick.

Here are some illustrations of those parameters:

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

        |----------------|      total_width
    ┌────────────────────────┐
    │                        │
    │  ┌─┐              ┌─┐  │
    │  │ │              │ │  │
    │ │   │            │   │ │
    │ └───┘            └───┘ │
    │                        │
    │                        │

#### Printing

Print the hook as is. Despite the slicer warnining me about floating bridge
anchors and loose extrusions, it printed just fine for me without supports on
my Prusa i3 MK4.

#### Mounting

The hooks are only offset on the horizontal axis. Keep that in mind when
mounting them.

#### Unmounting

As you usually don´t have access to the back of your HSW, you can´t just push
the hook out fro, the back. You can try to carefull pull it out a little on the
pertrusion and then try to get a small flat-head screwdriver under the overhang
of the hex-insert and try to pry it out. This worked for me so far.
*/

/* [User parameters] */
// Exact distance between keyholes, center to center.
total_width = 278.5;
keyhole_small_diameter = 5;
keyhole_small_width = 1.5;
keyhole_large_diameter = 10;
keyhole_large_width = 2.0;


/* [HSW Specific parameters] */
$fa = 8;
$fs = 0.25;
tolerance = 0;
decoration = false;
structure = [[2]];
hsw_horizontal_distance_unit = 40.88;

include <hws_openscad_attachments_and_connectors/hws_insert_util.scad>

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

width_hsw_horizontal_distance_unit = round(total_width / hsw_horizontal_distance_unit); // The total width expressed in HSW horizontal distance units, rounded to the nearest integer
gap = total_width - (width_hsw_horizontal_distance_unit * hsw_horizontal_distance_unit); // The gap between the total width and the nearest multiple of the HSW horizontal distance unit

union() {
    insert_plug_adv(structure);
    translate([gap/2, 0, 0]) union() {
        translate([0, 0, -keyhole_small_width]) cylinder(d=keyhole_small_diameter, h=keyhole_small_width);
        translate([0, 0, 0 - keyhole_small_width - keyhole_large_width]) cylinder(d=keyhole_large_diameter, h=keyhole_large_width);
    }
}
