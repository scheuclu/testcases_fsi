
SOWER_EXECUTABLE=/home/pavery/bin/sower

# Postprocess fluid solution
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Pressure_steady.bin \
                  -output postpro/coupled/Pressure_steady

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Mach_steady.bin \
                  -output postpro/coupled/Mach_steady

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Velocity_steady.bin \
                  -output postpro/coupled/Velocity_steady

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Displacement_steady.bin \
                  -output postpro/coupled/Displacement_steady
