GetData;

PauseTime = 0.025;

f=inline('x/180.0*pi','x');

set(gcf,'doublebuffer','on');    %gcf返回当前Figure对象的句柄值；打开双缓冲 
hold on;                                %这样就可以在一个图上 画多条线
axis([-80,520,-120,280]);         %创建坐标系
set(gca,'XTick',[-80:40:520]) 
set(gca,'YTick',[-120:40:280])

frame = 1;

L_THIGH_ANGLE = Data(frame,12)-90-HipOffset;
L_CALF_ANGLE =  Data(frame,14)-90+Data(frame,12)-HipOffset;
L_ANKLE_ANGLE = Data(frame,14)-90+Data(frame,12)-Data(frame,16)-HipOffset;

R_THIGH_ANGLE = -Data(frame,11)-90-HipOffset;
R_CALF_ANGLE =  -Data(frame,13)-90-Data(frame,11)-HipOffset;
R_ANKLE_ANGLE = -Data(frame,13)-90-Data(frame,11)+Data(frame,15)-HipOffset;

H = 0;
G = H - ANKLE*exp(f(R_ANKLE_ANGLE)*1i);
F = G - CALF*exp(f(R_CALF_ANGLE)*1i);
E = F - THIGH*exp(f(R_THIGH_ANGLE)*1i);
HF = H + 40*exp(f(R_ANKLE_ANGLE-90)*1i);
HB = H + 40*exp(f(R_ANKLE_ANGLE+90)*1i);

A =  E;
B = A + THIGH*exp(f(L_THIGH_ANGLE)*1i);
C = B + CALF*exp(f(L_CALF_ANGLE)*1i);
D = C + ANKLE*exp(f(L_ANKLE_ANGLE)*1i);
DF = D + 40*exp(f(L_ANKLE_ANGLE + 90)*1i);
DB = D + 40*exp(f(L_ANKLE_ANGLE - 90)*1i);
%real是实部，imag是虚部
l1 = plot(real([A,B]),imag([A,B]),'b','linewidth',4,'linestyle','-');     %画出黄色的连杆
l2 = plot(real([B,C]),imag([B,C]),'b','linewidth',4,'linestyle','-');    %画出蓝色的连杆
l3 = plot(real([C,D]),imag([C,D]),'b','linewidth',4,'linestyle','-');     %画出青色的连杆
l4 = plot(real([DF,DB]),imag([DF,DB]),'b','linewidth',4,'linestyle','-');
%real是实部，imag是虚部
r1 = plot(real([E,F]),imag([E,F]),'r','linewidth',4,'linestyle','-');     %画出黄色的连杆
r2 = plot(real([F,G]),imag([F,G]),'r','linewidth',4,'linestyle','-');    %画出蓝色的连杆
r3 = plot(real([G,H]),imag([G,H]),'r','linewidth',4,'linestyle','-');     %画出青色的连杆
r4 = plot(real([HF,HB]),imag([HF,HB]),'r','linewidth',4,'linestyle','-');

while 1
 
if frame > FrameNumber
    frame = 1;
end

L_THIGH_ANGLE = Data(frame,12)-90-HipOffset;
L_CALF_ANGLE =  Data(frame,14)-90+Data(frame,12)-HipOffset;
L_ANKLE_ANGLE = Data(frame,14)-90+Data(frame,12)-Data(frame,16)-HipOffset;

R_THIGH_ANGLE = -Data(frame,11)-90-HipOffset;
R_CALF_ANGLE =  -Data(frame,13)-90-Data(frame,11)-HipOffset;
R_ANKLE_ANGLE = -Data(frame,13)-90-Data(frame,11)+Data(frame,15)-HipOffset;

if frame < FrameNumber/2
    G = H - ANKLE*exp(f(R_ANKLE_ANGLE)*1i);
    F = G - CALF*exp(f(R_CALF_ANGLE)*1i);
    E = F - THIGH*exp(f(R_THIGH_ANGLE)*1i);
    HF = H + 40*exp(f(R_ANKLE_ANGLE-90)*1i);
    HB = H + 40*exp(f(R_ANKLE_ANGLE+90)*1i);

    A =  E;
    B = A + THIGH*exp(f(L_THIGH_ANGLE)*1i);
    C = B + CALF*exp(f(L_CALF_ANGLE)*1i);
    D = C + ANKLE*exp(f(L_ANKLE_ANGLE)*1i);
    DF = D + 40*exp(f(L_ANKLE_ANGLE + 90)*1i);
    DB = D + 40*exp(f(L_ANKLE_ANGLE - 90)*1i);
else
    A = B - THIGH*exp(f(L_THIGH_ANGLE)*1i);
    B = C - CALF*exp(f(L_CALF_ANGLE)*1i);
    C = D - ANKLE*exp(f(L_ANKLE_ANGLE)*1i);
    DF = D + 40*exp(f(L_ANKLE_ANGLE + 90)*1i);
    DB = D + 40*exp(f(L_ANKLE_ANGLE - 90)*1i);
    
    E = A;
    F = E + THIGH*exp(f(R_THIGH_ANGLE)*1i);
    G = F + CALF*exp(f(R_CALF_ANGLE)*1i);
    H = G + ANKLE*exp(f(R_ANKLE_ANGLE)*1i);
    HF = H + 40*exp(f(R_ANKLE_ANGLE-90)*1i);
    HB = H + 40*exp(f(R_ANKLE_ANGLE+90)*1i);
end

set(l1,'xdata',real([A,B]),'ydata',imag([A,B]));
set(l2,'xdata',real([B,C]),'ydata',imag([B,C]));
set(l3,'xdata',real([C,D]),'ydata',imag([C,D]));
set(l4,'xdata',real([DF,DB]),'ydata',imag([DF,DB]));

set(r1,'xdata',real([E,F]),'ydata',imag([E,F]));
set(r2,'xdata',real([F,G]),'ydata',imag([F,G]));
set(r3,'xdata',real([G,H]),'ydata',imag([G,H]));
set(r4,'xdata',real([HF,HB]),'ydata',imag([HF,HB]));

plot(real(D),imag(D),'bx'); 
plot(real(H),imag(H),'rx'); 
plot(real(A),imag(A),'gx'); 

pause(PauseTime);
frame = frame +1;
end

