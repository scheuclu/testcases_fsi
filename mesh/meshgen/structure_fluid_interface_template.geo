<nacanodes>

/*linelist = {};*/
/*For j In {1 : <numnodes>-1}*/
  /*Line(j) = {j, j+1};*/
  /*linelist += {j};*/
/*EndFor*/
/*Line(<numnodes>)={<numnodes>,1};*/
/*linelist+={<numnodes>};*/

/*Line Loop(<numnodes>) = linelist[];*/
/*extlines[]=Extrude {0, 0, <thickness>} {*/
  /*Line{linelist[]};*/
/*};*/

/*slipmovingsurfacelist={};*/
/*For j In {1:<numnodes>}*/
  /*slipmovingsurfacelist+={extlines[j]};*/
/*EndFor*/
/*Physical Surface("SlipMovingSurface") ={slipmovingsurfacelist[]};*/

slipsurfacelist={};
ext={};

/*linelist = {};*/
For j In {1 : <numnodes>-1}
  Line(j*10) = {j, j+1};
  ext[]=Extrude {0, 0, <thickness>} {
  Line{j*10};
  };
  slipsurfacelist+={ext[1]};
EndFor

//Final closing line
Line(<numnodes>*10)={<numnodes>,1};
ext[]=Extrude {0, 0, <thickness>} {
Line{<numnodes>*10};
};
slipsurfacelist+={ext[1]};


Physical Surface("SlipMovingSurface") ={slipsurfacelist[]};

