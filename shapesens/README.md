# testcases

This repository provides automated test cases for the validation of sensitivity analysis in AERO-F

## Structure
The repository consists of 3 main folders
 * euler_bodyfitted
 * laminar_bodyfitted
 * rans_bodyfitt
 * euler_embedded
 * laminar_embedded
 * rans_embedded
 
Each folder contains
 * manual_sensitivity analysis(SA)
 * analytic SA by direct method
 * analytic SA by adjoint method
 
## Usage
The validation process is fully automated.
Each folder contains both a template folder for the manual SA as well as the analytic ones.
Script are then called, that create actual simulation folders out of the templates. The simulations are then run in parallel.
A pyhthon script compares the results and writes them into a .csv-file. These results are then plotted as .eps-file by another python script

## Scripts
Each folder contains the following scripts
 * deletefolders.sh
 * genfolders.sh
 * runall.sh
 * calc.py
 * plot.py
 
The scripts are meant to be called in that order.

### deletefolder.sh
This script deletes possible remnats of previous simulations. It only leaves the template folders intact.

## genfolders.sh
This script creates the actual simulation folders out of the template folders.
For the manual SA, several folders are created that differ only by the stepsize for the final difference.


## runall.sh
This script runs all calculations on the newly created folders in parallel.

## calc.py
This script creates .csv-files for both the manual and analytic sensitivity analysis. For the manual SA oit also calculates the central difference.

## plot.py
This script plots the results for the manual and analytic SA for camparison. The plots are saved as .eps-file.
