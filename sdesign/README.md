#Input files
##../mesh/runmesh/structure_volume.sdesignnodes
This file contains all nodes of the structure. It has a specific structure and is creates from the full structure input file by a script.
The format is as following

    FENODES
    <node-ID> <x-coord> <y-coord> <z-coord>
    .         .         .         .
    .         .         .         .
    .         .         .         .
    END

##structure_volume.sdesign
Main input file for SDesign. Contains all informations about Design elements, abstract shape variables and their connection

#Output
##structure_volume.der
Contains the derivatives of the node-postitions with respect to the abstract shape parameters.

The format is

    Vector MODE under Attributes for FluidNodes
    <total number of nodes>
    <index of abstract varible (i)>
    <dx1/dsi>  <dy1/dsi> <dz1/dsi>
    <dx2/dsi>  <dy2/dsi> <dz2/dsi>
    .          .         .
    .          .         .
    .          .         .

##structure_volume.vmo
Contains the nodal displacement of the structure due to the shape variable values specified in 'structure_volume.sdesign'.

The format is

    Vector MODE under Attributes for FluidNodes
    <total number of nodes>
    0
    <dx1>  <dy1> <dz1>
    <dx2>  <dy2> <dz2>
    .      .     .
    .      .     .
    .      .     .
##structure_volume.nodefile
Contains the position of all displaced nodes in a format that can directly be re-used for the AERO-S input file:

The format is

    NODE
    *
    <node-ID> <x-coord> <y-coord> <z-coord>
    .         .         .         .
    .         .         .         .
    .         .         .         .


