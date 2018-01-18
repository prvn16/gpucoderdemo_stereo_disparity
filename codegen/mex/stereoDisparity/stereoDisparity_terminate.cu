/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * stereoDisparity_terminate.cu
 *
 * Code generation for function 'stereoDisparity_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "stereoDisparity.h"
#include "stereoDisparity_terminate.h"
#include "_coder_stereoDisparity_mex.h"
#include "stereoDisparity_data.h"

/* Function Definitions */
void stereoDisparity_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void stereoDisparity_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (stereoDisparity_terminate.cu) */
