clear;
cla;
DataStart = GrabParameter();%获取以下参数
ParameterNumber = DataStart(1);%参数总数
THIGH = DataStart(2);%大腿长
CALF = DataStart(3);%小腿长
ANKLE = DataStart(4);%脚踝高
HipOffset = DataStart(5);%前倾角度
PeriodTime = DataStart(6);%单周期总时长
TimeUnit = 20.0;%微分时间元
FrameNumber = PeriodTime/TimeUnit;%帧数

Data = zeros(FrameNumber,20);%20个舵机的角度数据
DataEP = zeros(FrameNumber,12);

%RollOffset = 0;
%Scale = 0;

RollOffset = 5;
Scale = 1.10;

for i = 1:FrameNumber%获取数据
    DataRaw= GrabData(TimeUnit * i);
    Data( i , : ) = DataRaw(1:20);
    Data( i , 9 ) = Data( i , 9 )-RollOffset;
    Data( i , 10 ) = Data( i , 10 ) + RollOffset;
    Data( i , 17 ) = DataRaw( 17 ) + RollOffset*Scale;
    Data( i , 18 ) = DataRaw( 18 ) - RollOffset*Scale;
    DataEP(i ,:) = DataRaw(21:32);
end


f=inline('x/180.0*pi','x');%函数，角度变为弧度

%奇数右，偶数左
%set(gcf,'doublebuffer','on');    %gcf返回当前Figure对象的句柄值；打开双缓冲
grid on;
hold on;
axis([-80  2320  -600  600  -40 360]);
set(gca,'XTick',[-80:80:2320]);
set(gca,'YTick',[-600:40:600]);
set(gca,'ZTick',[  -40:40:360]);
xlabel('X');
ylabel('Y');
zlabel('Z');

O = [1  0  0  0
    0  1  0  0
    0  0  1  0
    0  0  0  1];

frame = 1;

toAR = Trans(0,-17.5,0);
toBR = Rot(f(Data(frame,9)),0,0)*Trans(0,-14.5,-46.5);
toCR = Rot(0,f(Data(frame,11)),0)*Trans(0,0,-THIGH);
toDR = Rot(0,f(Data(frame,13)),0)*Trans(0,0,-CALF);
toER = Rot(0,f(-Data(frame,15)),0)*Trans(0,0,-ANKLE)*Rot(f(Data(frame,17)),0,0);

toAL = Trans(0,17.5,0);
toBL = Rot(f(Data(frame,10)),0,0)*Trans(0,14.5,-46.5);
toCL = Rot(0,f(-Data(frame,12)),0)*Trans(0,0,-THIGH);
toDL = Rot(0,f(-Data(frame,14)),0)*Trans(0,0,-CALF);
toEL = Rot(0,f(Data(frame,16)),0)*Trans(0,0,-ANKLE)*Rot(f(Data(frame,18)),0,0);


ER = Trans(0,0,0);
DR = ER*inv(toER);
CR = DR*inv(toDR);
BR = CR*inv(toCR);
AR = BR*inv(toBR);
O = AR*inv(toAR);
AL = O*toAL;
BL = AL*toBL;
CL = BL*toCL;
DL = CL*toDL;
EL = DL*toEL;

%右腿的五条线段，从上到下
r1 = plot3(grabX(O,AR),grabY(O,AR),grabZ(O,AR),'r','linewidth',4,'linestyle','-');
r2 = plot3(grabX(AR,BR),grabY(AR,BR),grabZ(AR,BR),'r','linewidth',4,'linestyle','-');
r3 = plot3(grabX(BR,CR),grabY(BR,CR),grabZ(BR,CR),'r','linewidth',4,'linestyle','-');
r4 = plot3(grabX(CR,DR),grabY(CR,DR),grabZ(CR,DR),'r','linewidth',4,'linestyle','-');
r5 = plot3(grabX(DR,ER),grabY(DR,ER),grabZ(DR,ER),'r','linewidth',4,'linestyle','-');
%左腿的五条线段，从上到下
l1 = plot3(grabX(O,AL),grabY(O,AL),grabZ(O,AL),'b','linewidth',4,'linestyle','-');
l2 = plot3(grabX(AL,BL),grabY(AL,BL),grabZ(AL,BL),'b','linewidth',4,'linestyle','-');
l3 = plot3(grabX(BL,CL),grabY(BL,CL),grabZ(BL,CL),'b','linewidth',4,'linestyle','-');
l4 = plot3(grabX(CL,DL),grabY(CL,DL),grabZ(CL,DL),'b','linewidth',4,'linestyle','-');
l5 = plot3(grabX(DL,EL),grabY(DL,EL),grabZ(DL,EL),'b','linewidth',4,'linestyle','-');


while 1
    if frame > FrameNumber
        frame = 1;
    end
    
    toAR = Trans(0,-17.5,0);
    toBR = Rot(f(Data(frame,9)),0,0)*Trans(0,-14.5,-46.5);
    toCR = Rot(0,f(Data(frame,11)),0)*Trans(0,0,-THIGH);
    toDR = Rot(0,f(Data(frame,13)),0)*Trans(0,0,-CALF);
    toER = Rot(0,f(-Data(frame,15)),0)*Trans(0,0,-ANKLE)*Rot(f(Data(frame,17)),0,0);

    
    toAL = Trans(0,17.5,0);
    toBL = Rot(f(Data(frame,10)),0,0)*Trans(0,14.5,-46.5);
    toCL= Rot(0,f(-Data(frame,12)),0)*Trans(0,0,-THIGH);
    toDL= Rot(0,f(-Data(frame,14)),0)*Trans(0,0,-CALF);
    toEL = Rot(0,f(Data(frame,16)),0)*Trans(0,0,-ANKLE)*Rot(f(Data(frame,18)),0,0);
    
    if frame<= floor(FrameNumber/2)
        %ER = Trans(0,0,0);
        ER(3,4) = 0;
        DR = ER*inv(toER);
        CR = DR*inv(toDR);
        BR = CR*inv(toCR);
        AR = BR*inv(toBR);
        O = AR*inv(toAR);
        AL = O*toAL;
        BL = AL*toBL;
        CL = BL*toCL;
        DL = CL*toDL;
        EL = DL*toEL;
    else
        EL(3,4) = 0;
        DL = EL*inv(toEL);
        CL = DL*inv(toDL);
        BL = CL*inv(toCL);
        AL = BL*inv(toBL);
        O = AL*inv(toAL);
        AR = O*toAR;
        BR = AR*toBR;
        CR = BR*toCR;
        DR = CR*toDR;
        ER = DR*toER;
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
    
    plot3(O(1,4),O(2,4),O(3,4),'g.');
    
    pause(0.005);
    frame = frame + 1;
end


function T = Trans(x,y,z)%平移矩阵
T = [1  0  0  x
    0  1  0  y
    0  0  1  z
    0  0  0  1];
end

function T = Rot(x,y,z)%旋转矩阵
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

function X = grabX(T1,T2)%提取X数值
X = [T1(1,4) T2(1,4)];
end

function Y = grabY(T1,T2)%提取Y数值
Y = [T1(2,4) T2(2,4)];
end

function Z = grabZ(T1,T2)%提取Z数值
Z = [T1(3,4) T2(3,4)];
end

function A = MatrixA(alpha,a,Theta,d)%生成A矩阵
A = Rot(0,0,Theta)*Trans(0,0,d)*Trans(a,0,0)*Rot(alpha,0,0);
end


