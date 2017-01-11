Point(1) = {0.0,0.0,-0.01};
Point(2) = {0.030154,0.028467,-0.01};
Point(3) = {0.11698,0.049459,-0.01};
Point(4) = {0.25,0.059412,-0.01};
Point(5) = {0.41318,0.057513,-0.01};
Point(6) = {0.58682,0.046702,-0.01};
Point(7) = {0.75,0.031603,-0.01};
Point(8) = {0.88302,0.01657,-0.01};
Point(9) = {0.96985,0.0054135,-0.01};
Point(10) = {1.0,0.00126,-0.01};
Point(11) = {0.96985,-0.0054135,-0.01};
Point(12) = {0.88302,-0.01657,-0.01};
Point(13) = {0.75,-0.031603,-0.01};
Point(14) = {0.58682,-0.046702,-0.01};
Point(15) = {0.41318,-0.057513,-0.01};
Point(16) = {0.25,-0.059412,-0.01};
Point(17) = {0.11698,-0.049459,-0.01};
Point(18) = {0.030154,-0.028467,-0.01};


linelist = {};
For j In {1 : 18-1}
  Line(j) = {j, j+1};
  linelist += {j};
EndFor
Line(18)={18,1};
linelist+={18};

Line Loop(18) = linelist[];
Plane Surface(1) = {18};
extsurf[]=Extrude {0, 0, -2.0} {
  Surface{1};
};

Physical Volume("Structure Volume") = {extsurf[1]};

slipmovingsurfacelist={};
For j In {1:18}
  slipmovingsurfacelist+={extsurf[j+1]};
EndFor
Physical Surface("SlipMovingSurface") ={slipmovingsurfacelist[]};



Mesh.LabelType=2;
Mesh.SurfaceFaces=1;
Mesh.SurfaceNumbers=1;
Mesh.ColorCarousel=2;

