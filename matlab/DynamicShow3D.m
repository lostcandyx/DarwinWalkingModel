GetData;

PauseTime = 0.005;

f=inline('x/180.0*pi','x');

%set(gcf,'doublebuffer','on');    %gcf返回当前Figure对象的句柄值；打开双缓冲
grid on;
hold on;
axis([-200  200  -200  200  -300 100]);
set(gca,'XTick',[-200:40:200]);
set(gca,'YTick',[-200:40:200]);
set(gca,'ZTick',[-320:40:80]);
xlabel('X');
ylabel('Y');
zlabel('Z');

frame = 1;

to7 = Trans(0,-37,0);
AR = to7;
to9 = Rot(0,0,f(Data(frame,7)))*Trans(0,0,0);
BR = AR*to9;
to11 = Rot(f(Data(frame,9)),0,0);
to13 = Rot(0,f(Data(frame,11)+HipOffset),0)*Trans(0,0,-THIGH);
CR = BR*to11*to13;
to15 = Rot(0,f(Data(frame,13)),0)*Trans(0,0,-CALF);
DR = CR*to15;
to17 = Rot(0,f(-Data(frame,15)),0)*Rot(f(Data(frame,17)),0,0)*Trans(0,0,-ANKLE);
ER = DR*to17;

to8 = Trans(0,37,0);
AL = to8;
to10 = Rot(0,0,f(Data(frame,8)))*Trans(0,0,0);
BL = AL*to10;
to12 = Rot(f(Data(frame,10)),0,0);
to14 = Rot(0,f(-Data(frame,12)+HipOffset),0)*Trans(0,0,-THIGH);
CL = BL*to12*to14;
to16 = Rot(0,f(-Data(frame,14)),0)*Trans(0,0,-CALF);
DL = CL*to16;
to18 = Rot(0,f(Data(frame,16)),0)*Rot(f(Data(frame,18)),0,0)*Trans(0,0,-ANKLE);
EL = DL*to18;


r1 = plot3(grabX(O,AR),grabY(O,AR),grabZ(O,AR),'r','linewidth',4,'linestyle','-');
r2 = plot3(grabX(AR,BR),grabY(AR,BR),grabZ(AR,BR),'r','linewidth',4,'linestyle','-');
r3 = plot3(grabX(BR,CR),grabY(BR,CR),grabZ(BR,CR),'r','linewidth',4,'linestyle','-');
r4 = plot3(grabX(CR,DR),grabY(CR,DR),grabZ(CR,DR),'r','linewidth',4,'linestyle','-');
r5 = plot3(grabX(DR,ER),grabY(DR,ER),grabZ(DR,ER),'r','linewidth',4,'linestyle','-');

l1 = plot3(grabX(O,AL),grabY(O,AL),grabZ(O,AL),'b','linewidth',4,'linestyle','-');
l2 = plot3(grabX(AL,BL),grabY(AL,BL),grabZ(AL,BL),'b','linewidth',4,'linestyle','-');
l3 = plot3(grabX(BL,CL),grabY(BL,CL),grabZ(BL,CL),'b','linewidth',4,'linestyle','-');
l4 = plot3(grabX(CL,DL),grabY(CL,DL),grabZ(CL,DL),'b','linewidth',4,'linestyle','-');
l5 = plot3(grabX(DL,EL),grabY(DL,EL),grabZ(DL,EL),'b','linewidth',4,'linestyle','-');

frame = 1;

while 1
    if frame > FrameNumber
        frame = 1;
    end
    
    to7 = Trans(0,-37,0);
    AR = to7;
    to9 = Rot(0,0,f(Data(frame,7)))*Trans(0,0,0);
    BR = AR*to9;
    to11 = Rot(f(Data(frame,9)),0,0);
    to13 = Rot(0,f(Data(frame,11)+HipOffset),0)*Trans(0,0,-THIGH);
    CR = BR*to11*to13;
    to15 = Rot(0,f(Data(frame,13)),0)*Trans(0,0,-CALF);
    DR = CR*to15;
    to17 = Rot(0,f(-Data(frame,15)),0)*Rot(f(Data(frame,17)),0,0)*Trans(0,0,-ANKLE);
    ER = DR*to17;
    
    to8 = Trans(0,37,0);
    AL = to8;
    to10 = Rot(0,0,f(Data(frame,8)))*Trans(0,0,0);
    %to10 = Rot(0,0,f(DataANGLE(frame,1)))*Trans(0,0,0);
    BL = AL*to10;
    to12 = Rot(f(Data(frame,10)),0,0);
    %to12 = Rot(f(DataANGLE(frame,2)),0,0);
    to14 = Rot(0,f(-Data(frame,12)+HipOffset),0)*Trans(0,0,-THIGH);
    %to14 = Rot(0,f(-DataANGLE(frame,3)),0)*Trans(0,0,-THIGH);
    CL = BL*to12*to14;
    to16 = Rot(0,f(-Data(frame,14)),0)*Trans(0,0,-CALF);
    %to16 = Rot(0,f(-DataANGLE(frame,4)),0)*Trans(0,0,-CALF);
    DL = CL*to16;
    to18 = Rot(0,f(Data(frame,16)),0)*Rot(f(Data(frame,18)),0,0)*Trans(0,0,-ANKLE);
    %to18 = Rot(0,f(DataANGLE(frame,5)),0)*Rot(f(DataANGLE(frame,6)),0,0)*Trans(0,0,-ANKLE);
    EL = DL*to18;
    
    set(r1,'xdata',grabX(O,AR),'ydata',grabY(O,AR),'zdata',grabZ(O,AR));
    set(r2,'xdata',grabX(AR,BR),'ydata',grabY(AR,BR),'zdata',grabZ(AR,BR));
    set(r3,'xdata',grabX(BR,CR),'ydata',grabY(BR,CR),'zdata',grabZ(BR,CR));
    set(r4,'xdata',grabX(CR,DR),'ydata',grabY(CR,DR),'zdata',grabZ(CR,DR));
    set(r5,'xdata',grabX(DR,ER),'ydata',grabY(DR,ER),'zdata',grabZ(DR,ER));
    plot3(ER(1,4),ER(2,4),ER(3,4),'r.');
    plot3(DR(1,4),DR(2,4),DR(3,4),'r.');
    
    set(l1,'xdata',grabX(O,AL),'ydata',grabY(O,AL),'zdata',grabZ(O,AL));
    set(l2,'xdata',grabX(AL,BL),'ydata',grabY(AL,BL),'zdata',grabZ(AL,BL));
    set(l3,'xdata',grabX(BL,CL),'ydata',grabY(BL,CL),'zdata',grabZ(BL,CL));
    set(l4,'xdata',grabX(CL,DL),'ydata',grabY(CL,DL),'zdata',grabZ(CL,DL));
    set(l5,'xdata',grabX(DL,EL),'ydata',grabY(DL,EL),'zdata',grabZ(DL,EL));
    plot3(EL(1,4),EL(2,4),EL(3,4),'b.');
    plot3(DL(1,4),DL(2,4),DL(3,4),'b.');
    
    Tad_1 = SetTransform(DataEP(frame,1),DataEP(frame,2)+37,DataEP(frame,3)-LEG,DataEP(frame,4),DataEP(frame,5),DataEP(frame,6));
    Tad_2 = SetTransform(DataEP(frame,7),DataEP(frame,8)-37,DataEP(frame,9)-LEG,DataEP(frame,10),DataEP(frame,11),DataEP(frame,12));
    Tda_1 = inv(Tad_1);
    Tda_2 = inv(Tad_2);
    Tcd_1 = SetTransform(0,0,-ANKLE,DataANGLE(frame,6),0,0);
    Tcd_2 = SetTransform(0,0,-ANKLE,DataANGLE(frame,12),0,0);
    Tdc_1 = inv(Tcd_1);
    Tdc_2 = inv(Tcd_2);
    Tac_1 = Tad_1*Tdc_1;
    Tac_2 = Tad_2*Tdc_2;
    Tde_1 = Trans(0,0,ANKLE);
    Tde_2 = Trans(0,0,ANKLE);
    Tae_1 = Tad_1*Tde_1;
    Tae_2 = Tad_2*Tde_2;
    
    DataPOINT(frame,1) = -Tac_1(1,1)*sin(atan2(-Tac_1(1,1),Tac_1(2,1)))+Tac_1(2,1)*cos(atan2(-Tac_1(1,1),Tac_1(2,1)));
    
    plot3(Tad_1(1,4),Tad_1(2,4),Tad_1(3,4),'gx');
    plot3(Tad_2(1,4),Tad_2(2,4),Tad_2(3,4),'kx');
    
    plot3(Tac_1(1,4),Tac_1(2,4),Tac_1(3,4),'g.');
    plot3(Tac_2(1,4),Tac_2(2,4),Tac_2(3,4),'k.');
    
    plot3(Tae_1(1,4),Tae_1(2,4),Tae_1(3,4),'c.');
    plot3(Tae_2(1,4),Tae_2(2,4),Tae_2(3,4),'m.');
    
    pause(PauseTime);
    frame = frame + 1;
end

function T = Trans(x,y,z)
T = [1  0  0  x
    0  1  0  y
    0  0  1  z
    0  0  0  1];
end

function T = Rot(x,y,z)
RotX = [1      0         0       0
    0  cos(x)  -sin(x)   0
    0  sin(x)  cos(x)    0
    0      0         0      1];
RotY = [cos(y)  0  sin(y)  0
    0        1    0      0
    -sin(y)  0  cos(y)  0
    0       0     0     1];
RotZ = [cos(z)  -sin(z)  0  0
    sin(z)   cos(z)  0  0
    0        0       1  0
    0        0       0  1];
T = RotX*RotY*RotZ;
end

function X = grabX(T1,T2)
X = [T1(1,4) T2(1,4)];
end

function Y = grabY(T1,T2)
Y = [T1(2,4) T2(2,4)];
end

function Z = grabZ(T1,T2)
Z = [T1(3,4) T2(3,4)];
end

function A = MatrixA(alpha,a,Theta,d)
A = Rot(0,0,Theta)*Trans(0,0,d)*Trans(a,0,0)*Rot(alpha,0,0);
end

function m = SetTransform(x,y,z,a,b,c)
Cx = cos(a * pi / 180.0);
Cy = cos(b * pi / 180.0);
Cz = cos(c * pi / 180.0);
Sx = sin(a * pi / 180.0);
Sy = sin(b * pi / 180.0);
Sz = sin(c * pi / 180.0);

m = [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
m(1,1) = Cz * Cy;                         %[0]
m(1,2) = Cz * Sy * Sx - Sz * Cx;    %[1]
m(1,3) = Cz * Sy * Cx + Sz * Sx;   %[2]
m(1,4) = x;                                  %[3]
m(2,1) = Sz * Cy;                         %[4]
m(2,2) = Sz * Sy * Sx + Cz * Cx;   %[5]
m(2,3) = Sz * Sy * Cx - Cz * Sx;    %[6]
m(2,4) = y;                                  %[7]
m(3,1) = -Sy;                               %[8]
m(3,2) = Cy * Sx;                         %[9]
m(3,3) = Cy * Cx;                        %[10]
m(3,4) = z;                                  %[11]
end

