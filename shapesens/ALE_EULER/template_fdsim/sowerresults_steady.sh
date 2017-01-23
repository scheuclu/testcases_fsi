#/usr/bin/bash!
SOWER_EXECUTABLE=/home/pavery/bin/sower

rm ./postpro/*

# Postprocess fluid solution plus
for quantity in Displacement Mach Pressure Mach Velocity; do
  for direction in plus minus; do
    echo "${quantity} ${direction}"
    cmd="-fluid -merge -con ../../../mesh/sower/fluid_sowered.con -mesh ../../../mesh/sower/fluid_sowered.msh -result results/${quantity}_steady_${direction}.bin -output postpro/${quantity}_steady_${direction}"
    $SOWER_EXECUTABLE $cmd
    #$SOWER_EXECUTABLE -fluid -merge -con ../../../mesh/sower/fluid_sowered.con \
                      #-mesh ../../../mesh/sower/fluid_sowered.msh \
                      #-result results/${quantity}_steady_${direction}.bin \
                      #-output postpro/${quantity}_steady_${direction}
  done
done
