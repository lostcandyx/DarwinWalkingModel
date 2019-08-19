GetData;

PauseTime = 0.05;

f=inline('x/180.0*pi','x');

%set(gcf,'doublebuffer','on');    %gcf返回当前Figure对象的句柄值；打开双缓冲
grid on;
hold on;
axis([-80  1520  -800  800  0 400]);
set(gca,'XTick',[-80:80:1520]);
set(gca,'YTick',[-800:80:800]);
set(gca,'ZTick',[     0:40:400]);
xlabel('X');
ylabel('Y');
zlabel('Z');

O = [1  0  0  0
    0  1  0  0
    0  0  1  0
    0  0  0  1];

frame = 1;

to7 = Trans(0,-37,0);
%AR = to7;
to9 = Rot(0,0,f(Data(frame,7)))*Trans(0,0,-35);
%BR = AR*to9;
to11 = Rot(f(Data(frame,9)),0,0);
to13 = Rot(0,f(Data(frame,11)+HipOffset),0)*Trans(0,0,-THIGH);
%CR = BR*to11*to13;
to15 = Rot(0,f(Data(frame,13)),0)*Trans(0,0,-CALF);
%DR = CR*to15;
to17 = Rot(0,f(-Data(frame,15)),0)*Trans(0,0,-ANKLE);
%ER = DR*to17;

to8 = Trans(0,37,0);
%AL = to8;
to10 = Rot(0,0,f(Data(frame,8)))*Trans(0,0,-35);
%BL = AL*to10;
to12 = Rot(f(Data(frame,10)),0,0);
to14 = Rot(0,f(-Data(frame,12)+HipOffset),0)*Trans(0,0,-THIGH);
%CL = BL*to12*to14;
to16 = Rot(0,f(-Data(frame,14)),0)*Trans(0,0,-CALF);
%DL = CL*to16;
to18 = Rot(0,f(Data(frame,16)),0)*Trans(0,0,-ANKLE);
%EL = DL*to18;

ER = Trans(0,0,0);
DR = ER*inv(to17);
CR = DR*inv(to15);
BR = CR*inv(to13)*inv(to11);
AR = BR*inv(to9);
O = AR*inv(to7);
AL = O*to8;
BL = AL*to10;
CL = BL*to12*to14;
DL = CL*to16;
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


while 1
    if frame > FrameNumber
        frame = 1;
    end
    
    to7 = Trans(0,-37,0);
    %AR = to7;
    to9 = Rot(0,0,f(Data(frame,7)))*Trans(0,0,-35);
    %BR = AR*to9;
    to11 = Rot(f(Data(frame,9)),0,0);
    to13 = Rot(0,f(Data(frame,11)+HipOffset),0)*Trans(0,0,-THIGH);
    %CR = BR*to11*to13;
    to15 = Rot(0,f(Data(frame,13)),0)*Trans(0,0,-CALF);
    %DR = CR*to15;
    to17 = Rot(0,f(-Data(frame,15)),0)*Trans(0,0,-ANKLE);
    %ER = DR*to17;
    
    to8 = Trans(0,37,0);
    %AL = to8;
    to10 = Rot(0,0,f(Data(frame,8)))*Trans(0,0,-35);
    %BL = AL*to10;
    to12 = Rot(f(Data(frame,10)),0,0);
    to14 = Rot(0,f(-Data(frame,12)+HipOffset),0)*Trans(0,0,-THIGH);
    %CL = BL*to12*to14;
    to16 = Rot(0,f(-Data(frame,14)),0)*Trans(0,0,-CALF);
    %DL = CL*to16;
    to18 = Rot(0,f(Data(frame,16)),0)*Trans(0,0,-ANKLE);
    %EL = DL*to18;
    
    if 0 < frame&&frame< floor(FrameNumber/2 + 1)
        %ER = Trans(0,0,0);
        ER(3,4) = 0;
        DR = ER*inv(to17);
        CR = DR*inv(to15);
        BR = CR*inv(to13)*inv(to11);
        AR = BR*inv(to9);
        O = AR*inv(to7);
        AL = O*to8;
        BL = AL*to10;
        CL = BL*to12*to14;
        DL = CL*to16;
        EL = DL*to18;
    else
        EL(3,4) = 0;
        DL = EL*inv(to18);
        CL = DL*inv(to16);
        BL = CL*inv(to12)*inv(to14);
        AL = BL*inv(to10);
        O = AL*inv(to8);
        AR = O*to7;
        BR = AR*to9;
        CR = BR*to11*to13;
        DR = CR*to15;
        ER = DR*to17;
    end
    
    set(r1,'xdata',grabX(O,AR),'ydata',grabY(O,AR),'zdata',grabZ(O,AR));
    set(r2,'xdata',grabX(AR,BR),'ydata',grabY(AR,BR),'zdata',grabZ(AR,BR));
    set(r3,'xdata',grabX(BR,CR),'ydata',grabY(BR,CR),'zdata',grabZ(BR,CR));
    set(r4,'xdata',grabX(CR,DR),'ydata',grabY(CR,DR),'zdata',grabZ(CR,DR));
    set(r5,'xdata',grabX(DR,ER),'ydata',grabY(DR,ER),'zdata',grabZ(DR,ER));
    plot3(ER(1,4),ER(2,4),ER(3,4),'r.');
    
    set(l1,'xdata',grabX(O,AL),'ydata',grabY(O,AL),'zdata',grabZ(O,AL));
    set(l2,'xdata',grabX(AL,BL),'ydata',grabY(AL,BL),'zdata',grabZ(AL,BL));
    set(l3,'xdata',grabX(BL,CL),'ydata',grabY(BL,CL),'zdata',grabZ(BL,CL));
    set(l4,'xdata',grabX(CL,DL),'ydata',grabY(CL,DL),'zdata',grabZ(CL,DL));
    set(l5,'xdata',grabX(DL,EL),'ydata',grabY(DL,EL),'zdata',grabZ(DL,EL));
    plot3(EL(1,4),EL(2,4),EL(3,4),'b.');
    
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


