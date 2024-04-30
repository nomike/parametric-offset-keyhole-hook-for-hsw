This hook allows you to mount objects with those common keyholes on a HSW.
It creates an insert, whith a hook to which you can attach such a hole.
As the distnace between two keyholes is not always a multiple of the distance
between two adjecant Honeycomb fields, it calculates how much this is off and
offsets the hook accordingly.

#### Configuration

* Measure the distance between the centers of the keyholes with a ruler and
    put it in `total_width`.

In most cases this should be enough.

However, if your keyhole doesn't look standard, you can do further adjustements:

* Measure the smaller diameter of the keyhole with a caliper and put it in
    `keyhole_small_diameter`.

* Measure the larger diameter of the keyhole with a caliper and put it in
    `keyhole_large_diameter`.

* `keyhole_small_width` corresponds to the thickness of the material the
    keyhole is in. I'm hanging a small parts magazine to my HSW and the metal
    sheet of it's casing is 1.5mm thick.

Here are some illustrations of those parameters:

```plaintext
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
```

#### Printing

See <print-instructions.md>.

#### Mounting

The hooks are only offset on the horizontal axis. Keep that in mind when
mounting them.

#### Unmounting

As you usually don´t have access to the back of your HSW, you can´t just push
the hook out fro, the back. You can try to carefull pull it out a little on the
pertrusion and then try to get a small flat-head screwdriver under the overhang
of the hex-insert and try to pry it out. This worked for me so far.

#### Acknowledgements

This project uses the [OpenSCAD HWS Attachments and Connectors](https://github.com/neclimdul/hws_openscad_attachments_and_connectors) Copyright (c) 2023 James Gilliland.

It also uses the concepts and designs of [Honeycomb storage wall](https://www.printables.com/model/152592-honeycomb-storage-wall).

#### ThingiVerse

<https://www.thingiverse.com/thing:6576683>

#### GitHub

<https://github.com/nomike/parametric-offset-keyhole-hook-for-hsw>
