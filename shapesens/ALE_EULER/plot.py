#!/usr/bin/python3

import os as os
import matplotlib.pyplot as plt
import numpy as np

print("\033[1;4;092mREADING INPUT-FILES                                                             \033[00m")

machvalues=[]
with open('scriptinput/machnumbers') as f:
  for line in f.readlines():
    machvalues.append(float(line))
print("./scriptinput/machnumbers")

anglevalues=[]
with open('scriptinput/angles') as f:
  for line in f.readlines():
    anglevalues.append(float(line))
print("./scriptinput/angles")

shapevars=[]
NUMSHAPEVARS=0
with open('scriptinput/shapevariables') as f:
  for line in f.readlines():
    shapevars.append(int(line))
    NUMSHAPEVARS=NUMSHAPEVARS+1
print("./scriptinput/shapevariables")

#The following lines reads integer key-value pairs from a text file
with open('info') as f:
  for line in f.readlines():
    exec(line.split()[0] + " = int(line.split()[1])")
print("./info")

#check if all neccessary information has been read from the info-file
if 'NUMANGLES' in locals() and 'NUMPERTURB' in locals():
  print('Info-file is valid!')#green
else:
  print('\x1b[0;37;42m' + 'Info-file is invalid!' + '\x1b[0m')
  exit()

print("\033[1;4;092mCREATING PLOTS                                                                 \033[00m")
for index_mach in range(1,NUMMACH+1):
    for index_angle in range(1,NUMANGLES+1):
        epsfile='./results/Ma'+str(machvalues[index_mach-1])+'/angle'+str(anglevalues[index_angle-1])+".png"
        print("Writing file"+epsfile)


        #create filenames of analytic simulations resuts from the manual on
        filedirect = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_direct.csv'
        fileadjoint = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_adjoint.csv'
        data_direct  = np.genfromtxt('./results/'+filedirect,  delimiter=',',max_rows=8, skip_header=1,skip_footer=0, names=['absvar', 'dLx', 'dLy'])
        data_adjoint = np.genfromtxt('./results/'+fileadjoint, delimiter=',',max_rows=8, skip_header=1,skip_footer=0, names=['absvar', 'dLx', 'dLy'])

        #check if an appropriate outputfolder exist; if not, create it
        if  not os.path.exists("./results/Ma"+str(machvalues[index_mach-1])):
          os.makedirs("./results/Ma"+str(machvalues[index_mach-1]))
        #create the name of the output file

        # f, (ax1, ax2) = plt.subplots(NUMSHAPEVARS, 2, sharey=False)
        f, (multiaxes) = plt.subplots(NUMSHAPEVARS, 2, sharey=False)
        f.set_size_inches(10,14)
        plt.suptitle("Euler-bodyfitted  \nangle="+str(anglevalues[index_angle-1])+"\nmach="+str(machvalues[index_mach-1]))
        multiaxes[NUMSHAPEVARS-1][0].set_xlabel("step-size")
        multiaxes[NUMSHAPEVARS-1][1].set_xlabel("step-size")
        multiaxes[0][0].set_title("Sensitivity Lx")
        multiaxes[0][1].set_title("Sensitivity Ly")

        for shapevarindex in range(1,NUMSHAPEVARS+1):
              print("CURSHAPEVARINDEX "+str(shapevarindex))

              data_sim = np.genfromtxt('./results/fdsim_'+str(index_mach)+'_'+str(index_angle)+'_'+str(shapevarindex)+'.csv', delimiter=',', skip_header=1,skip_footer=0, names=['stepsize', 'dLx', 'dLy'])

              ################################################
              # Plots for Lx sensitivity                     #
              ################################################
              multiaxes[shapevarindex-1][0].semilogx(data_sim['stepsize'], data_sim['dLx'],'-o', color='r', label='numerical result')
              multiaxes[shapevarindex-1][0].semilogx(data_sim['stepsize'], data_sim['dLx']*0+data_direct["dLx"][shapevars[shapevarindex-1]-1],'-', color='k', label='direct method')
              multiaxes[shapevarindex-1][0].semilogx(data_sim['stepsize'], data_sim['dLx']*0+data_adjoint["dLx"][shapevars[shapevarindex-1]-1],'--', color='g', label='adjoint method')
              multiaxes[shapevarindex-1][0].semilogx(data_sim['stepsize'], data_sim['dLx']*0,'-.', color='b', linewidth=4)
              multiaxes[shapevarindex-1][0].set_ylabel("dLx/ds_"+str(shapevars[shapevarindex-1]))

              ################################################
              # Plots for Ly sensitivity                     #
              ################################################
              multiaxes[shapevarindex-1][1].semilogx(data_sim['stepsize'], data_sim['dLy'],'-o', color='r', label='numerical result')
              multiaxes[shapevarindex-1][1].semilogx(data_sim['stepsize'], data_sim['dLy']*0+data_direct["dLy"][shapevars[shapevarindex-1]-1],'-', color='k', label='direct method')
              multiaxes[shapevarindex-1][1].semilogx(data_sim['stepsize'], data_sim['dLy']*0+data_adjoint["dLy"][shapevars[shapevarindex-1]-1],'--', color='g', label='adjoint method')
              multiaxes[shapevarindex-1][1].semilogx(data_sim['stepsize'], data_sim['dLy']*0,'-.', color='b', linewidth=4)
              multiaxes[shapevarindex-1][1].yaxis.tick_right()
              multiaxes[shapevarindex-1][1].set_ylabel("dLy/ds_"+str(shapevars[shapevarindex-1]))

              ################################################
              # Shift plots and add legends                  #
              ################################################
              # box = multiaxes[shapevarindex-1][0].get_position()
              # multiaxes[shapevarindex-1][0].set_position([box.x0, box.y0 + box.height * 0.3,
                                   # box.width, box.height * 0.7])
              # box = multiaxes[shapevarindex-1][1].get_position()
              # multiaxes[shapevarindex-1][1].set_position([box.x0*1.1, box.y0 + box.height * 0.3,
                                   # box.width*1.1, box.height * 0.7])
              # Put a legend below current axis
        multiaxes[NUMSHAPEVARS-1][0].legend(loc='upper center', bbox_to_anchor=(1, -0.20),
                                fancybox=True, shadow=True, ncol=5)

        plt.savefig(epsfile, format='png', dpi=200)
        plt.close()
print("\033[1;4;092m                                                                                \033[00m")
