/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * stereoDisparity_initialize.cu
 *
 * Code generation for function 'stereoDisparity_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "stereoDisparity.h"
#include "stereoDisparity_initialize.h"
#include "_coder_stereoDisparity_mex.h"
#include "stereoDisparity_data.h"

/* Function Definitions */
void stereoDisparity_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (stereoDisparity_initialize.cu) */
