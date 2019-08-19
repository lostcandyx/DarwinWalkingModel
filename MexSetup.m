clc
clear
mex  ./src/GrabData.cpp -I".\include" -I".\src" -output ./matlab/GrabData.mexw64
mex  ./src/GrabParameter.cpp -I".\include" -I".\src" -output ./matlab/GrabParameter.mexw64
disp('±‡“ÎÕÍ≥…');