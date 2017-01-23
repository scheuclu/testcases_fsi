#/usr/bin/bash!

printf "\033[92m###########################################################\033[00m\n"
printf "\033[92m#  Automatic simulation folder creation                   #\033[00m\n"
printf "\033[92m###########################################################\033[00m\n\n"
machnumbers=$(<scriptinput/machnumbers)
perturbations=$(<scriptinput/perturbations)
attackangles=$(<scriptinput/angles)
shapevars=$(<scriptinput/shapevariables)

printf "\033[92mMACHNUMBERS\033[00m:\n$machnumbers\n"
printf "\033[92mATTACKANGLES\033[00m:\n$attackangles\n"
printf "\033[92mPERTURBATIONS\033[00m:\n$perturbations\n\n"
printf "\033[92mSHAPEVARS\033[00m:\n$shapevars\n\n"

printf "\033[1;4;92mSTARTING FOLDER CREATION                                                        \033[00m\n"
index_mach=1
for curmach in ${machnumbers}
do
  index_angle=1
  for curangle in ${attackangles[@]}
  do
    cp -r template_ana anasim_${index_mach}_${index_angle}
    echo "anasim_${index_mach}_${index_angle}  MACH:${curmach}  ANGLE:${curangle}"

    ###########################################################################
    # SED commands for Sensitivity Analysis - files                           #
    ###########################################################################

    #puts the missing sections into the newly created aero-f input file
    #this replacements need to be done before any other
    for sec in sec_equations sec_time_sens; do
      python2.6 ./scriptinput/replacescript.py file=./anasim_${index_mach}_${index_angle}/fluidfile_sens_direct.inp key=${sec} text=./scriptinput/${sec}
      python2.6 ./scriptinput/replacescript.py file=./anasim_${index_mach}_${index_angle}/fluidfile_sens_adjoint.inp key=${sec} text=./scriptinput/${sec}
      #python2.6 ./scriptinput/replacescript.py file=./anasim_${index_mach}_${index_angle}/naca_aerof.steady key=${sec} text=./scriptinput/${sec}
    done

    for sec in sec_meshmotion sec_space sec_surfaces sec_bc sec_referencestate; do
      python2.6 ./scriptinput/replacescript.py file=./anasim_${index_mach}_${index_angle}/fluidfile_sens_direct.inp key=${sec} text=../scriptinput/${sec}
      python2.6 ./scriptinput/replacescript.py file=./anasim_${index_mach}_${index_angle}/fluidfile_sens_adjoint.inp key=${sec} text=../scriptinput/${sec}
      #python2.6 ./scriptinput/replacescript.py file=./anasim_${index_mach}_${index_angle}/naca_aerof.steady key=${sec} text=./scriptinput/${sec}
    done

    #the following comand executes pwd, thes replaces all "/" by "\/" and stores the result in PWD
    PWD=$(echo $(pwd) | sed -r 's/\//\\\//g')
    sed -i "s/<casepath>/$PWD/g" ./anasim_${index_mach}_$index_angle/run_sens.sh
    sed -i "s/<index_angle>/$index_angle/g" ./anasim_${index_mach}_${index_angle}/run_sens.sh
    sed -i "s/<index_mach>/$index_mach/g" ./anasim_${index_mach}_${index_angle}/run_sens.sh

    #replace angle of attach in anasim file
    sed -i "s/<alpha>/$curangle/g" ./anasim_${index_mach}_$index_angle/fluidfile_sens_direct.inp
    sed -i "s/<alpha>/$curangle/g" ./anasim_${index_mach}_$index_angle/fluidfile_sens_adjoint.inp
    #sed -i "s/<alpha>/$curangle/g" ./anasim_${index_mach}_$index_angle/naca_aerof.steady

    #replace machnumber in anasim file
    sed -i "s/<machnumber>/$curmach/g" ./anasim_${index_mach}_$index_angle/fluidfile_sens_direct.inp
    sed -i "s/<machnumber>/$curmach/g" ./anasim_${index_mach}_$index_angle/fluidfile_sens_adjoint.inp
    #sed -i "s/<machnumber>/$curmach/g" ./anasim_${index_mach}_$index_angle/naca_aerof.steady



    ###########################################################################
    # SED commands for Steady Analysis - files                                #
    ###########################################################################
    index_shapevar=1
    for curshapevar in ${shapevars[@]}
    do
      index_perturb=1
      for i in ${perturbations[@]}
      do
        cp -r template_fdsim fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}
        echo "fdsim_${index_mach}_${index_angle}  MACH:${curmach}  ANGLE:${curangle}  SHAPEVARIABLE:${curshapevar}  PERTURB:${i}"

        #replace the sections
        for sec in sec_equations sec_time_steady; do
          python2.6 ./scriptinput/replacescript.py file=./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/fluidfile_steady_plus.inp key=${sec} text=./scriptinput/${sec}
          python2.6 ./scriptinput/replacescript.py file=./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/fluidfile_steady_minus.inp key=${sec} text=./scriptinput/${sec}
        done

        for sec in sec_meshmotion sec_space sec_surfaces sec_bc sec_referencestate; do
          python2.6 ./scriptinput/replacescript.py file=./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/fluidfile_steady_plus.inp key=${sec} text=../scriptinput/${sec}
          python2.6 ./scriptinput/replacescript.py file=./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/fluidfile_steady_minus.inp key=${sec} text=../scriptinput/${sec}
        done

        #write siminfo file
        echo "machnumber: $curmach" >> fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/siminfo
        echo "perturb: $i" >> fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/siminfo
        echo "angle: $curangle" >> fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/siminfo

        #replace perturbation magnitude in SDESIGN file
        sed -i "s/<perturb_abs${curshapevar}>/$i/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/sdesign/naca_plus.sdesign
        sed -i "s/<perturb_abs${curshapevar}>/$i/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/sdesign/naca_minus.sdesign
        for j in `seq 1 10`;
        do
          sed -i "s/<perturb_abs${j}>/0.0/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/sdesign/naca_plus.sdesign
          sed -i "s/<perturb_abs${j}>/0.0/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/sdesign/naca_minus.sdesign
        done

        #replace angle of attach
        sed -i "s/<alpha>/$curangle/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/fluidfile_steady_plus.inp
        sed -i "s/<alpha>/$curangle/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/fluidfile_steady_minus.inp

        #replace machnumber
        sed -i "s/<machnumber>/$curmach/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/fluidfile_steady_plus.inp
        sed -i "s/<machnumber>/$curmach/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/fluidfile_steady_minus.inp

        #replace simulation index and path in run-script
        sed -i "s/<index_mach>/$index_mach/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/run_steady.sh
        sed -i "s/<index_angle>/$index_angle/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/run_steady.sh
        sed -i "s/<index_perturb>/$index_perturb/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/run_steady.sh
        sed -i "s/<index_shapevar>/$index_shapevar/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/run_steady.sh
        sed -i "s/<casepath>/$PWD/g" ./fdsim_${index_mach}_${index_angle}_${index_shapevar}_${index_perturb}/run_steady.sh
        index_perturb=$(($index_perturb + 1))
      done
      index_shapevar=$(($index_shapevar + 1))
    done
    index_angle=$(($index_angle + 1))
  done #done looping over angles

  #if [ -d ./results/Ma${curmach} ] ; then
    #rm -rf ./results/Ma${curmach}
  #else
    #mkdir ./results/Ma${curmach}
  #fi

  index_mach=$(($index_mach + 1))
done #done looping over machnumbers

printf "\033[1;4;92m                                                                                 \033[00m\n"

#writing some basic information to info file
#this information is later used by the pyhton scripts calc.py and plot.py
index_mach=$(($index_mach - 1))
index_angle=$(($index_angle - 1))
index_perturb=$(($index_perturb - 1))
index_shapevar=$(($index_shapevar - 1))
echo "NUMMACH $index_mach" >> info
echo "NUMANGLES $index_angle" >> info
echo "NUMPERTURB $index_perturb" >> info
echo "NUMSHAPEVARS $index_shapevar" >> info
