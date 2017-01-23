
SOWER_EXECUTABLE=/home/pavery/bin/sower

# Postprocess fluid solution plus
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Pressure_steady_plus.bin \
                  -output postpro/coupled/Pressure_steady_plus

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Mach_steady_plus.bin \
                  -output postpro/coupled/Mach_steady_plus

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Velocity_steady_plus.bin \
                  -output postpro/coupled/Velocity_steady_plus

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Displacement_steady_plus.bin \
                  -output postpro/coupled/Displacement_steady_plus




# Postprocess fluid solution minus
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Pressure_steady_minus.bin \
                  -output postpro/coupled/Pressure_steady_minus

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Mach_steady_minus.bin \
                  -output postpro/coupled/Mach_steady_minus

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Velocity_steady_minus.bin \
                  -output postpro/coupled/Velocity_steady_minus

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/coupled/Displacement_steady_minus.bin \
                  -output postpro/coupled/Displacement_steady_minus
