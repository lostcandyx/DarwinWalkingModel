#include "OutputData.h"
#include <fstream>
#include <iomanip>

using namespace std;
int AngleToValue(int id, double angle);

int main(int argc, char const *argv[])
{
    char s1[500];
    const int value[18] = {0, 0, 614, 410, 456, 567, 558, 457, 496, 510, 0, 0, 0, 0, 0, 0, 523, 510};
    int speed[18] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    int cnt = 0;
    double m_time = 0;
    const double unit_time = 22.0;
    const int frameNum = (int)(Walking::GetInstance()->PERIOD_TIME/unit_time）;
    const double RollOffset = 0;
    const double Scale = 0;

    bool debug_print = false;

    Walking::GetInstance()->Start();
    Walking::GetInstance()->Initialize();

    if (debug_print == true)
    {
        cout<<Walking::GetInstance()->X_OFFSET<<endl;
        cout<<Walking::GetInstance()->Y_OFFSET<<endl;
        cout<<Walking::GetInstance()->Z_OFFSET<<endl;
    }

    ofstream outf("Walking.txt");
    if (!outf.fail())
    {
        for (int frame = 0; frame < frameNum; frame++)
        {
            int output_value[18];
            for (int j = 0; j < 18; j++)
                output_value[j] = value[j];
            m_time = unit_time * frame;
            Walking::GetInstance()->SetTime(m_time);
            Walking::GetInstance()->Process();

            for (int id = 8; id < 18; id++)
            {
                //  id    8  9 10 11 12 13 14 15 16 17
                //m_Joint 9 10 11 12 13 14 15 16 17 18
                double m_angle = Walking::GetInstance()->m_Joint.GetAngle(id + 1);
                if (id == 10 || id == 11)
                    m_angle = -m_angle;
                //if (id == 17||id == 18) m_angle = -m_angle;
                switch (id)
                {
                case 8:
                    m_angle = m_angle - RollOffset;
                    break;
                case 9:
                    m_angle = m_angle + RollOffset;
                    break;
                case 10:
                    m_angle = -m_angle;
                    break;
                case 11:
                    m_angle = -m_angle;
                    break;
                case 16:
                    m_angle = m_angle + Scale * RollOffset;
                    break;
                case 17:
                    m_angle = m_angle - Scale * RollOffset;
                    break;
                }
                int m_value = AngleToValue(id, m_angle);
                output_value[id] = m_value;
            }
            //output txt
            for (int i = 0; i < 18; i++)
            {
                outf << output_value[i] << ' ';
            }
            outf << '\n';
            for (int i = 0; i < 18; i++)
            {
                outf << speed[i] << ' ';
            }
            outf << '\n';
        }
    }

    return 0;
}

int AngleToValue(int id, double angle)
{
    //------------------------based on experiment------------------------
    int Center[18] = {512, 512, 512, 512, 512, 512, 512, 512, 
                    504, 496, 553, 457, 247, 757, 523, 485, 511, 497};
    //-------------------------based on compute-------------------------
    // int Center[18] = {512, 512, 512, 512, 512, 512, 512, 512, 512, 512
    //                     ,551, 473, 322, 702, 539, 485, 512, 512};
    const double ratio = 1024 / 300;

    return ((int)(angle * ratio) + Center[id]);
}
// g++ main.cpp -I "E:\Program Files\MATLAB\R2017b\extern\include" -I "./include" -I "./src"
