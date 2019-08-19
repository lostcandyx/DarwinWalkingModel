GetData;

PauseTime = 0.025;

f=inline('x/180.0*pi','x');

set(gcf,'doublebuffer','on');    %gcf返回当前Figure对象的句柄值；打开双缓冲 
hold on;                                %这样就可以在一个图上 画多条线
axis([-200,200,-300,100]);       %创建坐标系
set(gca,'XTick',[-200:40:200]) 
set(gca,'YTick',[-300:40:100])

frame = 1;

A =  0;
B = A + THIGH*exp(f(Data(frame,12)-90-HipOffset)*1i);
C = B + CALF*exp(f(Data(frame,14)-90+Data(frame,12))*1i);
D = C + ANKLE*exp(f(Data(frame,14)-90+Data(frame,12)-Data(frame,16))*1i);
DF = D + 40*exp(f(Data(frame,14)-180+Data(frame,12)-Data(frame,16))*1i);
DB = D + 40*exp(f(Data(frame,14)+Data(frame,12)-Data(frame,16))*1i);

E =  0;
F = E + THIGH*exp(f(-Data(frame,11)+HipOffset-90)*1i);
G = F + CALF*exp(f(-Data(frame,13)-90-Data(frame,11))*1i);
H = G + ANKLE*exp(f(-Data(frame,13)-90-Data(frame,11)+Data(frame,15))*1i);
HF = H + 40*exp(f(-Data(frame,13)-180-Data(frame,11)+Data(frame,15))*1i);
HB = H + 40*exp(f(-Data(frame,13)-Data(frame,11)+Data(frame,15))*1i);
%real是实部，imag是虚部  
l1 = plot(real([A,B]),imag([A,B]),'b','linewidth',4,'linestyle','-');         %画出黄色的连杆
l2 = plot(real([B,C]),imag([B,C]),'b','linewidth',4,'linestyle','-');         %画出蓝色的连杆
l3 = plot(real([C,D]),imag([C,D]),'b','linewidth',4,'linestyle','-');        %画出青色的连杆
l4 = plot(real([DF,DB]),imag([DF,DB]),'b','linewidth',4,'linestyle','-');
%real是实部，imag是虚部  
r1 = plot(real([E,F]),imag([E,F]),'r','linewidth',4,'linestyle','-');           %画出黄色的连杆
r2 = plot(real([F,G]),imag([F,G]),'r','linewidth',4,'linestyle','-');          %画出蓝色的连杆
r3 = plot(real([G,H]),imag([G,H]),'r','linewidth',4,'linestyle','-');        %画出青色的连杆
r4 = plot(real([HF,HB]),imag([HF,HB]),'r','linewidth',4,'linestyle','-');

while 1
 
    if frame > FrameNumber
        frame = 1;
    end
A =  0;
B = A + THIGH*exp(f(Data(frame,12)-90)*1i)*exp(f(-HipOffset)*1i);
C = B + CALF*exp(f(Data(frame,14)-90+Data(frame,12))*1i)*exp(f(-HipOffset)*1i);
D = C + ANKLE*exp(f(Data(frame,14)-90+Data(frame,12)-Data(frame,16))*1i)*exp(f(-HipOffset)*1i);
DF = D + 40*exp(f(Data(frame,14)-180+Data(frame,12)-Data(frame,16))*1i)*exp(f(-HipOffset)*1i);
DB = D + 40*exp(f(Data(frame,14)+Data(frame,12)-Data(frame,16))*1i)*exp(f(-HipOffset)*1i);

E =  0;
F = E + THIGH*exp(f(-Data(frame,11)-90)*1i)*exp(f(-HipOffset)*1i);
G = F + CALF*exp(f(-Data(frame,13)-90-Data(frame,11))*1i)*exp(f(-HipOffset)*1i);
H = G + ANKLE*exp(f(-Data(frame,13)-90-Data(frame,11)+Data(frame,15))*1i)*exp(f(-HipOffset)*1i);
HF = H + 40*exp(f(-Data(frame,13)-180-Data(frame,11)+Data(frame,15))*1i)*exp(f(-HipOffset)*1i);
HB = H + 40*exp(f(-Data(frame,13)-Data(frame,11)+Data(frame,15))*1i)*exp(f(-HipOffset)*1i);

set(l1,'xdata',real([A,B]),'ydata',imag([A,B]));
set(l2,'xdata',real([B,C]),'ydata',imag([B,C]));
set(l3,'xdata',real([C,D]),'ydata',imag([C,D]));
set(l4,'xdata',real([DF,DB]),'ydata',imag([DF,DB]));

set(r1,'xdata',real([E,F]),'ydata',imag([E,F]));
set(r2,'xdata',real([F,G]),'ydata',imag([F,G]));
set(r3,'xdata',real([G,H]),'ydata',imag([G,H]));
set(r4,'xdata',real([HF,HB]),'ydata',imag([HF,HB]));

plot(real(H-100),imag(H-100),'r.'); 
plot(real(D+100),imag(D+100),'b.');

pause(PauseTime);
frame = frame +1;
end

