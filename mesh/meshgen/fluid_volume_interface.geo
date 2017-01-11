<nacanodes>

linelist = {};
For j In {1 : <numnodes>-1}
  Line(j) = {j, j+1};
  linelist += {j};
EndFor
Line(<numnodes>)={<numnodes>,1};
linelist+={<numnodes>};


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

surfaceextrude[]=Extrude {0, 0, -0.01} {
  Surface{3001};
};

