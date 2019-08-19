# 步态模型演示&输出
## 概述
本代码用于对Darwin OP2所带的步态模型进行分析和运用  
直接将源码分离出工程，为此裁剪掉了`Walking.cpp`中的一些参数，比如行走时参考的fb_gyro和rl_gyro，改为了定值，并且去除了一些参数传递以便模型能够独立运行。   
## 编译和运行
### 编译可视化模块\<DynamicShow\>
使用MATLAB指令，对mex进行初始化
```
mex -setup
```
运行文件MexSetup.m将对GrabParamter和GrabData两个模块进行编译，编译生成的mex文件在`matlab`文件夹中。
### 编译输出模块\<OutputData\>
使用控制台指令  
```
g++ ./src/OutputData.cpp -I "./include" -I "./src" -o ./debug/OutputData.exe
```
将OutputData编译debug中，名为`OutputData.exe`，编译生成的exe文件在`debug`文件夹中。
## 参数调节
**步态参数**使用ini文件进行参数管理，可以直接修改`config.ini`文件的文本就可以改变参数，一些参数的名称和意义如下。  

|  name  |  meaning  |  
|  :----:  |  :----:  |
|  x_offect  |  X方向偏置，负值为前倾  |
|  y_offect  |  Y方向偏置  |
|  z_offect  |  Z方向偏置，正值为下蹲  |
|  period_time  |  步态循环一周期的时间  |
|  foot_height  |  抬脚高度   |
|  hip_pitch_offset  |  胯部控制的身体前倾角度，正值前倾  |
|  x_move_amplitude  |  步长，前后位移量，正值前进  |
|  y_move_amplitude  |  侧移，左右位移量，正值前进  |
|  a_move_amplitude  |  偏转，控制转弯角度  |

**机械参数**内置在文件`src\Kinematics.cpp`中，主要是腿部的连杆长度，预置了两套参数，使用时取消备注就可以，参数名称和意义如下。  

|  name  |  meaning  |
|  :----:  |  :----:  |
|  THIGH_LENGTH  |  大腿长度  |
|  CALF_LENGTH  |  小腿长度  |
|  ANKLE_LENGTH  |  脚踝长度  |
|  LEG_LENGTH  |  全腿长度  |

## 动画演示
动画演示通过MATLAB实现，以下列出了代码和对应的效果。  
`GrabWalkingData.m` 绘制舵机数值曲线图。  
`DynamicShow2D.m` 2D动作仿真，身体不移动。  
`DynamicShow2DFloor.m` 2D动作仿真，有地面的设定，身体会移动。  
`DynamicShow3D.m` 3D动作仿真，身体不移动。  
`DynamicShow3DFloor.m` 3D动作仿真，有地面的设定，身体会移动。  
`DynamicShow3DHaoJie.m` 3D动作仿真，适应浩劫机器人的机械结构。  
## 动作输出
运行`debug`中的可执行文件`OutputData.exe`可以输出一个对应的TXT，格式为浩劫机器人的动作文件格式。
