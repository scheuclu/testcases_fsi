#!/usr/bin/bash

SOWER_EXECUTABLE=/home/pavery/bin/sower

# Postprocess fluid solution
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con -mesh ./mesh/sower/fluid_sowered.msh -result results/Pressure_unsteady.bin -output postpro/Pressure_unsteady
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con -mesh ./mesh/sower/fluid_sowered.msh -result results/Mach_unsteady.bin -output postpro/Mach_unsteady
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con -mesh ./mesh/sower/fluid_sowered.msh -result results/Velocity_unsteady.bin -output postpro/Velocity_unsteady
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con -mesh ./mesh/sower/fluid_sowered.msh -result results/Displacement_unsteady.bin -output postpro/Displacement_unsteady
