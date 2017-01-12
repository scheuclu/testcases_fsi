<nacanodes>

linelist = {};
For j In {1 : <numnodes>-1}
  Line(j) = {j, j+1};
  linelist += {j};
EndFor
Line(<numnodes>)={<numnodes>,1};
linelist+={<numnodes>};

Line Loop(<numnodes>) = linelist[];
Plane Surface(1) = {<numnodes>};
extsurf[]=Extrude {0, 0, <thickness>} {
  Surface{1}; Layers{1};
};

Physical Volume("Structure Volume") = {extsurf[1]};

slipmovingsurfacelist={};
For j In {1:<numnodes>}
  slipmovingsurfacelist+={extsurf[j+1]};
EndFor
Physical Surface("SlipMovingSurface") ={slipmovingsurfacelist[]};



Mesh.LabelType=2;
Mesh.SurfaceFaces=1;
Mesh.SurfaceNumbers=1;
Mesh.ColorCarousel=2;

