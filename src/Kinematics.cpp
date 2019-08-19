#include <math.h>
#include "Kinematics.h"

const double Kinematics::CAMERA_DISTANCE = 33.2; //mm
const double Kinematics::EYE_TILT_OFFSET_ANGLE = 40.0; //degree

const double Kinematics::LEG_SIDE_OFFSET = 37.0; //mm

//---------------------for Haojie----------------------
// const double Kinematics::THIGH_LENGTH = 76.49; //mm
// const double Kinematics::CALF_LENGTH = 73.98; //mm
// const double Kinematics::ANKLE_LENGTH = 31.55; //mm
// const double Kinematics::LEG_LENGTH = 182.02; //mm (THIGH_LENGTH + CALF_LENGTH + ANKLE_LENGTH)
//-----------------------------------------------------

//---------------------for Darwin----------------------
const double Kinematics::THIGH_LENGTH = 93.0; //mm
const double Kinematics::CALF_LENGTH = 93.0; //mm
const double Kinematics::ANKLE_LENGTH = 33.5; //mm
const double Kinematics::LEG_LENGTH = 219.5; //mm (THIGH_LENGTH + CALF_LENGTH + ANKLE_LENGTH)
//-----------------------------------------------------

Kinematics* Kinematics::m_UniqueInstance = new Kinematics();

Kinematics::Kinematics()
{
}

Kinematics::~Kinematics()
{
}
