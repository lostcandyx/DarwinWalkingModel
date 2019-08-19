clear;
cla;

DataStart = GrabParameter();

ParameterNumber = DataStart(1);
THIGH = DataStart(2);
CALF = DataStart(3);
ANKLE = DataStart(4);
LEG = THIGH + CALF + ANKLE;
HipOffset = DataStart(5);
PeriodTime = DataStart(6);
TimeUnit = 20.0;
FrameNumber = floor(PeriodTime/TimeUnit);
Data = zeros(FrameNumber,20);
DataEP = zeros(FrameNumber,12);
DataANGLE = zeros(FrameNumber,12);
PELVIS = zeros(FrameNumber,2);

for i = 1:FrameNumber
    DataRaw= GrabData(TimeUnit * i);
    PELVIS( i , : ) = DataRaw(45:46);
    Data( i , : ) = DataRaw(1:20);
    DataEP(i ,:) = DataRaw(21:32);
    DataANGLE(i ,:) = DataRaw(33:44);
    DataANGLE(i ,3) = DataANGLE(i ,3)-HipOffset;
    DataANGLE(i ,9) = DataANGLE(i ,9)-HipOffset;
end

O = [1  0  0  0
        0  1  0  0
        0  0  1  0
        0  0  0  1];