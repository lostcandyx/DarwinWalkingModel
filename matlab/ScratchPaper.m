clc;
clear;

%o->theta_AnkleRoll
coso = sym('coso');
sino = sym('sino');
L_ankle = sym('L_ankle');
L_leg = sym('L_leg');
sina = sym('sina');
sinb = sym('sinb');
sinc = sym('sinc');
cosa = sym('cosa');
cosb = sym('cosb');
cosc = sym('cosc');
x = sym('x');
y = sym('y');
z = sym('z');

Tad = [x x x x;x x x x;x x x x;x x x x];

Tad(1,1) = cosb*cosc;
Tad(1,2) = sina*sinb*cosc-cosa*sinc;
Tad(1,3) = cosa*sinb*cosc+sina*sinc;
Tad(1,4) = x;

Tad(2,1) = cosb*sinc;
Tad(2,2) = sina*sinb*sinc+cosa*cosc;
Tad(2,3) = cosa*sinb*sinc-sina*cosc;
Tad(2,4) = y;

Tad(3,1) = -sinb;
Tad(3,2) = sina*cosb;
Tad(3,3) = cosa*cosb;
Tad(3,4) = z-L_leg;

Tad(4,1) = 0;
Tad(4,2) = 0;
Tad(4,3) = 0;
Tad(4,4) = 1;

Tdc = [1 0 0  0
    0 coso sino 0
    0 -sino coso L_ankle
    0 0  0 1];

T = Tad*Tdc;

for i = 1:4
    for j = 1:4
        fprintf('%d = %s \n',(i-1)*4+j,T(i,j));
    end
end