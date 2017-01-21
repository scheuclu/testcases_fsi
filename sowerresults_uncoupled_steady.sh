
SOWER_EXECUTABLE=/home/pavery/bin/sower

# Postprocess fluid solution
$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/uncoupled/Pressure_steady.bin \
                  -output postpro/uncoupled/Pressure_steady

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/uncoupled/Mach_steady.bin \
                  -output postpro/uncoupled/Mach_steady

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/uncoupled/Velocity_steady.bin \
                  -output postpro/uncoupled/Velocity_steady

$SOWER_EXECUTABLE -fluid -merge -con ./mesh/sower/fluid_sowered.con \
                  -mesh ./mesh/sower/fluid_sowered.msh \
                  -result results/uncoupled/Displacement_steady.bin \
                  -output postpro/uncoupled/Displacement_steady
