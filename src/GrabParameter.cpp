#include "GrabData.h"

/*
*	nlhs 输出参数数量
*	plhs 指向输出参数的指针
*	nrhs 输入参数数目
*   prhs 指向输入参数的指针
*/

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	double *input_time, *output;
	int mrows, ncols;
	if (nlhs > 40)
	{

		mexErrMsgTxt("Too many output argumnets.");
	}

	//mrows = (int)mxGetM(prhs[0]);

	//ncols = (int)mxGetN(prhs[0]);

	//mexPrintf("mrows = %d\n", mrows);

	//mexPrintf("nclos = %d\n", ncols);

	// if (!mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) || !(mrows == 1 && ncols == 1))

	// 	mexErrMsgTxt("Input must be a noncomplex scalar double.");

	plhs[0] = mxCreateDoubleMatrix(1, 6, mxREAL);

	//input_time = mxGetPr(prhs[0]);
	output = mxGetPr(plhs[0]);

	Walking::GetInstance()->Initialize();
	Walking::GetInstance()->Start();
	output[0] = Walking::GetInstance()->PARAMETER_NUMBER;
	output[1] = Kinematics::GetInstance()->THIGH_LENGTH;
	output[2] = Kinematics::GetInstance()->CALF_LENGTH;
	output[3] = Kinematics::GetInstance()->ANKLE_LENGTH;
	output[4] = Walking::GetInstance()->HIP_PITCH_OFFSET;
	output[5] = Walking::GetInstance()->PERIOD_TIME;
}
