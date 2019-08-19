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
	if (nrhs != 1)

		mexErrMsgTxt("One input required.");

	if (nlhs > 40)
	{

		mexErrMsgTxt("Too many output argumnets.");
	}

	mrows = (int)mxGetM(prhs[0]);

	ncols = (int)mxGetN(prhs[0]);

	//mexPrintf("mrows = %d\n", mrows);

	//mexPrintf("nclos = %d\n", ncols);

	if (!mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) || !(mrows == 1 && ncols == 1))

		mexErrMsgTxt("Input must be a noncomplex scalar double.");

	plhs[0] = mxCreateDoubleMatrix(1,Walking::GetInstance()->PARAMETER_NUMBER, mxREAL);

	input_time = mxGetPr(prhs[0]);
	output = mxGetPr(plhs[0]);

	Walking::GetInstance()->Initialize();
	Walking::GetInstance()->Start();
	Walking::GetInstance()->SetTime(input_time[0]);
	Walking::GetInstance()->Process();

	for (int i = JointData::ID_R_SHOULDER_PITCH; i <= JointData::ID_HEAD_TILT; i++)
	{
		output[i-1] = Walking::GetInstance()->m_Joint.GetAngle(i);
		//mexPrintf("id:[%d] angle:[%.2lf]", i, output[i-1]);
		//if (i % 5 == 0)
		//    mexPrintf("\n");
	}
	for (int i = 0; i < 12; i++)
	{
		output[20 + i] = Walking::GetInstance()->GetEP(i);	
	}
	for (int i = 0; i < 12; i++)
	{
		output[32 + i] = Walking::GetInstance()->GetANGLE(i);
	}
	output[44] = Walking::GetInstance()->PELVIS_OFFSET_L;
	output[45] = Walking::GetInstance()->PELVIS_OFFSET_R;

}
