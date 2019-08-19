clear;

GetData;

x = 1:1:FrameNumber;
hold;
grid on;

plot(x,Data(: , 11),'r','linestyle','-','linewidth',2);
plot(x,Data(: , 12),'r','linestyle','--','linewidth',2);

plot(x,Data(: , 13),'y','linestyle','-','linewidth',2);
plot(x,Data(: , 14),'y','linestyle','--','linewidth',2);

plot(x,Data(: , 15),'g','linestyle','-','linewidth',2);
plot(x,Data(: , 16),'g','linestyle','--','linewidth',2);

plot(x,Data(: , 17),'c','linestyle','-','linewidth',2);
plot(x,Data(: , 18),'c','linestyle','--','linewidth',2);

plot(x,Data(: , 9),'m','linestyle','-','linewidth',2);
plot(x,Data(: , 10),'m','linestyle','--','linewidth',2);

plot(x,ANGLE(: , 2),'mx','MarkerSize',8,'linewidth',2);
plot(x,-ANGLE(: , 8),'m+','MarkerSize',8,'linewidth',2);

plot(x,ANGLE(: , 3),'rx','MarkerSize',8,'linewidth',2);
plot(x,-ANGLE(: , 9),'r+','MarkerSize',8,'linewidth',2);

plot(x,ANGLE(: , 4),'yx','MarkerSize',8,'linewidth',2);
plot(x,-ANGLE(: , 10),'y+','MarkerSize',8,'linewidth',2);

plot(x,-ANGLE(: , 5),'gx','MarkerSize',8,'linewidth',2);
plot(x,ANGLE(: , 11),'g+','MarkerSize',8,'linewidth',2);

plot(x,ANGLE(: , 6),'cx','MarkerSize',8,'linewidth',2);
plot(x,ANGLE(: , 12),'c+','MarkerSize',8,'linewidth',2);

plot(x,PELVIS(: , 1),'k+','MarkerSize',8,'linewidth',2);
plot(x,PELVIS(: , 2),'kx','MarkerSize',8,'linewidth',2);


axis([0,FrameNumber,-100,100]);
set(gca,'XTick',[0:1:FrameNumber]) 
set(gca,'YTick',[-90:10:90])

xlabel('时间点')  %x轴坐标描述
ylabel('角度') %y轴坐标描述

%legend('R HIP PITCH','L HIP PITCH','R KNEE','L KNEE','R ANKLE PITCH','L ANKLE PITCH');



