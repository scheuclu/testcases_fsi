#!/usr/bin/bash

SOWER_EXECUTABLE=/home/pavery/bin/sower

# Postprocess fluid solution
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con -mesh ./mesh/sower/fluid_sowered.msh -result results/Pressure.bin -output postpro/Pressure
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con -mesh ./mesh/sower/fluid_sowered.msh -result results/Mach.bin -output postpro/Mach
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con -mesh ./mesh/sower/fluid_sowered.msh -result results/Velocity.bin -output postpro/Velocity
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con -mesh ./mesh/sower/fluid_sowered.msh -result results/Displacement.bin -output postpro/Displacement
