#Sensitivity Analysis test-cases

This folder contains all test-cases for the Aeroelastic Sensitivity Analysis framework of [AERO-F](http://frg.bitbucket.org/aero-f/index.html).



##General

A variety of parameter combinations has to be tested in order to ensure full functionality of the SA framework.
We test the follwowing features:

- Equation type
   - Euler equations
   - Laminar Navier-Stokes equations
   - RANS equations
- Time formulations
  - Eulerian
  - Arbitrary Lagrangian Eulerian
- Sensitivity Analysis Method
  - Direct SA
  - Adjoint SA
- Sensitivity Type
  - Shape sensitivity
  - Mach sensitivity
  - AoA sensitivity

##Setup
All calculations are performed on a 4-digit NACA airfoil. The user is not restricted to a specific profile. The mesh generatiopn is fully scripted, and the mesh used can be easily changes by running just a few script:

### ./mesh/NACA_fourdigit_curvegen.m
creates the .csv-file "./mesh/nacanodes.txt" that contains the profile coorinates of the specified NACA profile.
### ./mesh/genmeshes.py
creates all relevant mesh files for the simulation based on the "./mesh/nacanodes.txt" file.
### ./preprocess.sh
calls Matcher and Sower on the mesh files and stores the results into "./mesh/matcher" and "./mesh/sower"

##Structure
This folder first splits into 3 subfolders that cover the different Sensitivity types
- [./shapesens](shapesens) covers sensitivity with respect to shape variables [README](./shapesens/README.md)
- [./machsens](machsens) convers LD sensitivity with respect to the free-stream mach number [README](./machsens/README.md)
- [./alphasens](alphasens) covers LD sensitivity with respect to the angle of attack [README](./alphasens/README.md)


##Results

The following table summarizes the Verification of results.



<table class="tg" style="undefined;table-layout: fixed; width: 510px">
<colgroup>
<col style="width: 79px">
<col style="width: 56px">
<col style="width: 45px">
<col style="width: 45px">
<col style="width: 45px">
<col style="width: 45px">
<col style="width: 45px">
<col style="width: 45px">
<col style="width: 45px">
<col style="width: 45px">
<col style="width: 45px">
</colgroup>
  <tr>
    <th class="tg-031e" colspan="2" rowspan="2"></th>
    <th class="tg-hgcj" colspan="3">Euler</th>
    <th class="tg-amwm" colspan="3">Laminar</th>
    <th class="tg-amwm" colspan="3">RANS</th>
  </tr>
  <tr>
    <td class="tg-s6z2">s</td>
    <td class="tg-s6z2">α</td>
    <td class="tg-s6z2">Ma</td>
    <td class="tg-baqh">s</td>
    <td class="tg-baqh">α</td>
    <td class="tg-baqh">Ma</td>
    <td class="tg-baqh">s</td>
    <td class="tg-baqh">α</td>
    <td class="tg-baqh">Ma</td>
  </tr>
  <tr>
    <td class="tg-e3zv" rowspan="2">ALE</td>
    <td class="tg-031e">Direct</td>
    <td class="tg-031e"> <a href="shapesens/euler_bodyfitted/results">?</a> </td>                 <!-- ALE-Direct-Euler-s -->
    <td class="tg-031e"> <a href="alphasens/euler_bodyfitted/results">?</a> </td>                 <!-- ALE-Direct-Euler-α -->
    <td class="tg-031e"> <a href="machsens/euler_bodyfitted/results">?</a> </td>                 <!-- ALE-Direct-Euler-Ma -->
    <td class="tg-yw4l"> <a href="shapesens/laminar_bodyfitted/results">?</a> </td>                 <!-- ALE-Direct-Laminar-s -->
    <td class="tg-yw4l"> <a href="alphasens/laminar_bodyfitted/results">?</a> </td>                 <!-- ALE-Direct-Laminar-α -->
    <td class="tg-yw4l"> <a href="machsens/laminar_bodyfitted/results">?</a> </td>                 <!-- ALE-Direct-Laminar-Ma -->
    <td class="tg-yw4l"> <a href="shapesens/rans_bodyfitted/results">?</a> </td>                 <!-- ALE-Direct-RANS-s -->
    <td class="tg-yw4l"> <a href="alphasens/rans_bodyfitted/results">?</a> </td>                 <!-- ALE-Direct-RANS-α -->
    <td class="tg-yw4l"> <a href="machsens/rans_bodyfitted/results">?</a> </td>                 <!-- ALE-Direct-RANS-Ma -->
  </tr>
  <tr>
    <td class="tg-031e">Adjoint</td>
    <td class="tg-031e"> <a href="shapesens/euler_bodyfitted/results">?</a> </td>                 <!-- ALE-Adjoint-Euler-s -->
    <td class="tg-031e"> <a href="alphasens/euler_bodyfitted/results">?</a> </td>                 <!-- ALE-Adjoint-Euler-α -->
    <td class="tg-031e"> <a href="machsens/euler_bodyfitted/results">?</a> </td>                 <!-- ALE-Adjoint-Euler-Ma -->
    <td class="tg-yw4l"> <a href="shapesens/laminar_bodyfitted/results">?</a> </td>                 <!-- ALE-Adjoint-Laminar-s -->
    <td class="tg-yw4l"> <a href="alphasens/laminar_bodyfitted/results">?</a> </td>                 <!-- ALE-Adjoint-Laminar-α -->
    <td class="tg-yw4l"> <a href="machsens/laminar_bodyfitted/results">?</a> </td>                 <!-- ALE-Adjoint-Laminar-Ma -->
    <td class="tg-yw4l"> <a href="shapesens/rans_bodyfitted/results">?</a> </td>                 <!-- ALE-Adjoint-RANS-s -->
    <td class="tg-yw4l"> <a href="alphasens/rans_bodyfitted/results">?</a> </td>                 <!-- ALE-Adjoint-RANS-α -->
    <td class="tg-yw4l"> <a href="machsens/rans_bodyfitted/results">?</a> </td>                 <!-- ALE-Adjoint-RANS-Ma -->
  </tr>
  <tr>
    <td class="tg-9hbo" rowspan="2">Embedded</td>
    <td class="tg-yw4l">Direct</td>
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Direct-Euler-s -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Direct-Euler-α -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Direct-Euler-Ma -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Direct-Laminar-s -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Direct-Laminar-α -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Direct-Laminar-Ma -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Direct-RANS-s -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Direct-RANS-α -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Direct-RANS-Ma -->
  </tr>
  <tr>
    <td class="tg-yw4l">Adjoint</td>
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Adjoint-Euler-s -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Adjoint-Euler-α -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Adjoint-Euler-Ma -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Adjoint-Laminar-s -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Adjoint-Laminar-α -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Adjoint-Laminar-Ma -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Adjoint-RANS-s -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Adjoint-RANS-α -->
    <td class="tg-yw4l">?</td>                 <!-- Embedded-Adjoint-RANS-Ma -->
  </tr>
</table>


where: 
- s Shape sensitivity
- α AoA sensitivity
- Ma Mach number sensitivity

and the results can be read as follows:
- ✓ Everything working properly
- ! Implemented, Running, but wrong results
- ~ Implemented but not working(segfault, floating-point exception etc)
- ✕ Not implemented
- ? Not tested yet
