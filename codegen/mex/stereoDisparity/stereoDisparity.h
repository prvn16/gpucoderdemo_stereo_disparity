/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * stereoDisparity.h
 *
 * Code generation for function 'stereoDisparity'
 *
 */

#ifndef STEREODISPARITY_H
#define STEREODISPARITY_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "stereoDisparity_types.h"

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void stereoDisparity(const uint8_T img0[581632], const uint8_T img1
    [581632], int16_T out_disp[145408]);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (stereoDisparity.h) */
