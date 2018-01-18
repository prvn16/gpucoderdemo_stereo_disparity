/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_stereoDisparity_api.cu
 *
 * Code generation for function '_coder_stereoDisparity_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "stereoDisparity.h"
#include "_coder_stereoDisparity_api.h"
#include "stereoDisparity_data.h"

/* Function Declarations */
static uint8_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[581632];
static uint8_T (*c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId))[581632];
static uint8_T (*emlrt_marshallIn(const mxArray *img0, const char_T *identifier))
  [581632];
static const mxArray *emlrt_marshallOut(const int16_T u[145408]);

/* Function Definitions */
static uint8_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[581632]
{
  uint8_T (*y)[581632];
  y = c_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static uint8_T (*c_emlrt_marshallIn(const mxArray *src, const
  emlrtMsgIdentifier *msgId))[581632]
{
  uint8_T (*ret)[581632];
  static const int32_T dims[2] = { 1136, 512 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "uint8", false, 2U,
    dims);
  ret = (uint8_T (*)[581632])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static uint8_T (*emlrt_marshallIn(const mxArray *img0, const char_T *identifier))
  [581632]
{
  uint8_T (*y)[581632];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(img0), &thisId);
  emlrtDestroyArray(&img0);
  return y;
}
  static const mxArray *emlrt_marshallOut(const int16_T u[145408])
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[2] = { 0, 0 };

  static const int32_T iv1[2] = { 284, 512 };

  y = NULL;
  m0 = emlrtCreateNumericArray(2, iv0, mxINT16_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m0, iv1, 2);
  emlrtAssign(&y, m0);
  return y;
}

void stereoDisparity_api(const mxArray * const prhs[2], const mxArray *plhs[1])
{
  int16_T (*out_disp)[145408];
  uint8_T (*img0)[581632];
  uint8_T (*img1)[581632];
  out_disp = (int16_T (*)[145408])mxMalloc(sizeof(int16_T [145408]));

  /* Marshall function inputs */
  img0 = emlrt_marshallIn(emlrtAlias(prhs[0]), "img0");
  img1 = emlrt_marshallIn(emlrtAlias(prhs[1]), "img1");

  /* Invoke the target function */
  stereoDisparity(*img0, *img1, *out_disp);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*out_disp);
}

/* End of code generation (_coder_stereoDisparity_api.cu) */
