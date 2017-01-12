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


Point(1000) = {0.0, 0.0, 0.0, 1.0};
Point(1001) = {0.0,-5.0, 0.0, 1.0};
Point(1002) = {-5.0, 0.0, 0.0, 1.0};
Point(1003) = {0.0, 5.0, 0.0, 1.0};
Point(1004) = {5.0, 0.0, 0.0, 1.0};

Circle(2001) = {1001,1000,1002};
Circle(2002) = {1002,1000,1003};
Circle(2003) = {1003,1000,1004};
Circle(2004) = {1004,1000,1001};


Line Loop(2005)={2001,2002,2003,2004};
Line Loop(2006)={linelist[]};

Plane Surface(3001) = {2005,2006};

surfaceextrude[]=Extrude {0, 0, -2.0} {
  Surface{3001};Layers{1};
};

Physical Volume("FluidMesh")={surfaceextrude[1]};
Physical Surface("InletFixedSurface")={surfaceextrude[2],surfaceextrude[3],surfaceextrude[4],surfaceextrude[5]};
Physical Surface("SymmetrySurface")={3001,surfaceextrude[0]};

slipmovingsurfacelist={};
For j In {1:18}
  slipmovingsurfacelist+={surfaceextrude[j+5]};
EndFor
Physical Surface("SlipMovingSurface") ={slipmovingsurfacelist[]};

