% The purpose of this file is to create node coordinates
% of four-digit NACA-type airfoils.
%
% The script will output a .csv-file with the desired coordinates
%
% This script will create any 4-digit NACA type airfoil nodes
% The user can choose meshsizes and the size of the far field
%

clear
close all
clc
%% user input

% Profile offset
% 0 offset means that the profile tip coincides with the cooridate systems
% 0-point
xo=0;
yo=0;
zo=0;

%NACA profile number
d1=0;
d2=0;
d3=1;
d4=2;

%chord length of the profile
c=1.0;

%total number of points along the top and bottom
numpoints=10;

%% Profile generations

%create even point distribution
x=linspace(0,c,numpoints);

%A cosinus function is used to shift the distributen from a uniform one, to
%a distribution where the points accumulate towards the leading and
%trailing edges
x=1/2*(1-cos(pi/c*x));

%realtive profile thickness
t=(10*d3+d4)/100;

yt=...
5*t*(0.2969.*sqrt(x./c)-0.1260.*(x./c)-0.3516.*(x./c).^2+0.2843.*(x./c).^3-0.1015.*(x./c).^4);

m=d1/100;
p=d2/10;

yc=...
    m/(p.^2)*(2*p.*(x/c)-(x/c).^2)            .*(x<p*c) + ...
    m/(1-p).^2*((1-2.*p)+2*p.*(x/c)-(x/c).^2) .*(x>=p*c);

yc(isnan(yc))=0;


dyxdx=...
    2*m/p^2.*(p-x/c)     .* (x<p*c) + ...
    2*m/(1-p)^2.*(p-x/c) .* (x>=p*c);

dyxdx(isnan(dyxdx))=0;

theta=atan(dyxdx);
xu=x-yt.*sin(theta);
xl=x+yt.*sin(theta);

yu=yc+yt.*cos(theta);
yl=yc-yt.*cos(theta);

z=x*0-0.01;

%subtract the offset
x=x-xo;
yt=yt-yo;
z=z-zo;


%% Plot if a display is availiable
if usejava('jvm') && ~feature('ShowFigureWindows')
    disp('No display availiable!');
else
    f=figure();
    hold on
    axis equal
    %axis off
    xlabel('x');
    ylabel('y');
    zlabel('z');
    p=plot3(x,yt,x*0,'-.',x,-yt,x*0);
    set(p,'LineSmoothing','on');

    p2=plot3(xu,yu,z,'m.-',xl,yl,z,'m.-');
    %axis equal

    x0=0;
    y0=0;
    z0=0;
    coordsize=0.01;

    plot3(x0+[0, coordsize, nan, 0, 0,         nan, 0, 0],...
          y0+[0, 0,         nan, 0, coordsize, nan, 0, 0],...
          z0+[0, 0,         nan, 0, 0,         nan, 0, coordsize],'-k' )

    text([x0+coordsize, x0,           x0],...
         [y0,           y0+coordsize, y0],...
         [z0,           z0,           z0+coordsize],...
         ['+X';'+Y';'+Z']);


    plot3(x0+[0, -coordsize, nan, 0,  0,          nan, 0, 0],...
          y0+[0, 0         , nan, 0, -coordsize,  nan, 0, 0],...
          z0+[0, 0         , nan, 0,  0,          nan, 0, -coordsize],'-k' )


    text([x0-coordsize, x0,           x0],...
         [y0,           y0-coordsize, y0],...
         [z0,           z0,           z0-coordsize],...
         ['-X';'-Y';'-Z']);
end





xl=x(2:end-1);
yl=yl(2:end-1);
zl=z(2:end-1);
 
points=[...
    xu'          yu'          z'
    flipud(xl') flipud(yl')  zl'];

%% Output

csvwrite('./nacanodes.txt',points);
