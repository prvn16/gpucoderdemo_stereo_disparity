/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * stereoDisparity.cu
 *
 * Code generation for function 'stereoDisparity'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "stereoDisparity.h"

/* Function Declarations */
static __global__ void stereoDisparity_kernel1(int16_T *out_disp, int32_T
  *min_cost);
static __global__ void stereoDisparity_kernel2(const uint8_T *img1, const
  uint8_T *img0, int32_T d, int32_T *diff_img);
static __global__ void stereoDisparity_kernel3(int32_T *diff_img, int32_T *a);
static __global__ void stereoDisparity_kernel4(int32_T *a, real_T *cost_v);
static __global__ void stereoDisparity_kernel5(real_T *cost_v, real_T *cost);
static __global__ void stereoDisparity_kernel6(int32_T d, real_T *cost, int16_T *
  out_disp, int32_T *min_cost);

/* Function Definitions */
static __global__ __launch_bounds__(512, 1) void stereoDisparity_kernel1(int16_T
  *out_disp, int32_T *min_cost)
{
  int32_T temp_cost;
  ;
  ;
  temp_cost = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x *
    blockIdx.y) + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
    threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x) +
                        threadIdx.x);
  if (!(temp_cost >= 145408)) {
    /*  modified algorithm for stereo disparity block matching */
    /*  In this implementation instead of finding shifted image ,indices are mapped accordingly */
    /*  to save memory and some processing RGBA column major packed data is used as input for */
    /*  Compatibility with CUDA intrinsics Convolution is performed using separable filters (Horizontal and then Vertical) */
    /*  gpu code generation pragma */
    /*  Stereo disparity Parameters */
    /*  WIN_RAD is the radius of the window to be operated,min_disparity is the minimum disparity level  */
    /*  the search continues max_disparity is the maximun disparity level the search continues */
    /*  Image dimensions for loop control */
    /*  The number of channels packed are 4 (RGBA) so as nChannels are 4 */
    /*  To store the raw differences */
    /* To store the minimum cost */
    /*  Store the final disparity */
    min_cost[temp_cost] = 99999999;
    out_disp[temp_cost] = 0;
  }
}

static __global__ __launch_bounds__(512, 1) void stereoDisparity_kernel2(const
  uint8_T *img1, const uint8_T *img0, int32_T d, int32_T *diff_img)
{
  uint32_T threadId;
  int32_T ind_h;
  int32_T rowIdx;
  int32_T ind_w1;
  int32_T colIdx;
  int32_T ind_w2;
  int32_T tDiff;
  int32_T kk;
  int32_T temp_cost;
  ;
  ;
  threadId = ((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
                blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
               threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x)
    + threadIdx.x;
  colIdx = (int32_T)(threadId / 300U);
  rowIdx = (int32_T)(threadId - (uint32_T)colIdx * 300U);
  if ((!(rowIdx >= 300)) && (!(colIdx >= 528))) {
    /*  Row index calculation */
    ind_h = rowIdx - 7;

    /*  Column indices calculation for left image */
    ind_w1 = colIdx - 7;

    /*  Row indices calculation for right image */
    ind_w2 = (colIdx + d) - 23;

    /*  Border clamping for row Indices */
    if (rowIdx - 7 <= 0) {
      ind_h = 1;
    }

    if (ind_h > 284) {
      ind_h = 284;
    }

    /*  Border clamping for column indices for left image */
    if (colIdx - 7 <= 0) {
      ind_w1 = 1;
    }

    if (ind_w1 > 512) {
      ind_w1 = 512;
    }

    /*  Border clamping for column indices for right image */
    if (ind_w2 <= 0) {
      ind_w2 = 1;
    }

    if (ind_w2 > 512) {
      ind_w2 = 512;
    }

    /*  In this step, Sum of absolute Differences is performed */
    /*  across tour channels. */
    tDiff = 0;
    for (kk = 0; kk < 4; kk++) {
      temp_cost = (int32_T)img0[(((ind_h - 1) << 2) + kk) + 1136 * (ind_w1 - 1)]
        - (int32_T)img1[(((ind_h - 1) << 2) + kk) + 1136 * (ind_w2 - 1)];
      if (temp_cost < 0) {
        temp_cost = -temp_cost;
      }

      if ((tDiff < 0) && (temp_cost < MIN_int32_T - tDiff)) {
        tDiff = MIN_int32_T;
      } else if ((tDiff > 0) && (temp_cost > MAX_int32_T - tDiff)) {
        tDiff = MAX_int32_T;
      } else {
        tDiff += temp_cost;
      }
    }

    /* Store the SAD cost into a matrix */
    diff_img[rowIdx + 300 * colIdx] = tDiff;
  }
}

static __global__ __launch_bounds__(512, 1) void stereoDisparity_kernel3(int32_T
  *diff_img, int32_T *a)
{
  int32_T temp_cost;
  ;
  ;
  temp_cost = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x *
    blockIdx.y) + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
    threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x) +
                        threadIdx.x);
  if (!(temp_cost >= 158400)) {
    /*  Aggregating the differences using separable convolution. Expect this to generate two Kernel */
    /*  using shared memory.The first kernel is the convolution with the horizontal kernel and second */
    /*  kernel operates on its output the column wise convolution. */
    a[temp_cost] = diff_img[temp_cost];
  }
}

static __global__ __launch_bounds__(1024, 1) void stereoDisparity_kernel4
  (int32_T *a, real_T *cost_v)
{
  real_T cv;
  int32_T temp_cost;
  int32_T threadIdY;
  int32_T threadIdX;
  __shared__ int32_T a_shared[1536];
  int32_T baseR;
  int32_T srow;
  int32_T strideRow;
  int32_T scol;
  int32_T strideCol;
  int32_T y_idx;
  int32_T baseC;
  int32_T x_idx;
  ;
  ;
  threadIdY = (int32_T)(blockDim.y * blockIdx.y + threadIdx.y);
  threadIdX = (int32_T)(blockDim.x * blockIdx.x + threadIdx.x);
  baseR = threadIdX;
  srow = (int32_T)threadIdx.x;
  strideRow = (int32_T)blockDim.x;
  scol = (int32_T)threadIdx.y;
  strideCol = (int32_T)blockDim.y;
  for (y_idx = srow; y_idx <= 31; y_idx += strideRow) {
    baseC = threadIdY;
    for (x_idx = scol; x_idx <= 47; x_idx += strideCol) {
      if ((baseR >= 0) && (baseR < 300) && ((baseC >= 0) && (baseC < 528))) {
        a_shared[y_idx + 32 * x_idx] = (int32_T)a[300 * baseC + baseR];
      } else {
        a_shared[y_idx + 32 * x_idx] = 0;
      }

      baseC += strideCol;
    }

    baseR += strideRow;
  }

  __syncthreads();
  if ((!(threadIdX >= 300)) && (!(threadIdY >= 512))) {
    cv = 0.0;
    for (temp_cost = 0; temp_cost < 17; temp_cost++) {
      cv += (real_T)a_shared[(int32_T)threadIdx.x + 32 * ((int32_T)threadIdx.y +
        ((temp_cost + threadIdY) - threadIdY))];
    }

    cost_v[threadIdX + 300 * threadIdY] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void stereoDisparity_kernel5(real_T
  *cost_v, real_T *cost)
{
  real_T cv;
  int32_T temp_cost;
  int32_T threadIdY;
  int32_T threadIdX;
  __shared__ real_T cost_v_shared[1536];
  int32_T baseR;
  int32_T srow;
  int32_T strideRow;
  int32_T scol;
  int32_T strideCol;
  int32_T y_idx;
  int32_T baseC;
  int32_T x_idx;
  ;
  ;
  threadIdY = (int32_T)(blockDim.y * blockIdx.y + threadIdx.y);
  threadIdX = (int32_T)(blockDim.x * blockIdx.x + threadIdx.x);
  baseR = threadIdX;
  srow = (int32_T)threadIdx.x;
  strideRow = (int32_T)blockDim.x;
  scol = (int32_T)threadIdx.y;
  strideCol = (int32_T)blockDim.y;
  for (y_idx = srow; y_idx <= 47; y_idx += strideRow) {
    baseC = threadIdY;
    for (x_idx = scol; x_idx <= 31; x_idx += strideCol) {
      if ((baseR >= 0) && (baseR < 300) && ((baseC >= 0) && (baseC < 512))) {
        cost_v_shared[y_idx + 48 * x_idx] = (real_T)cost_v[300 * baseC + baseR];
      } else {
        cost_v_shared[y_idx + 48 * x_idx] = 0.0;
      }

      baseC += strideCol;
    }

    baseR += strideRow;
  }

  __syncthreads();
  if ((!(threadIdX >= 284)) && (!(threadIdY >= 512))) {
    cv = 0.0;
    for (temp_cost = 0; temp_cost < 17; temp_cost++) {
      cv += cost_v_shared[((int32_T)threadIdx.x + ((temp_cost + threadIdX) -
        threadIdX)) + 48 * (int32_T)threadIdx.y];
    }

    cost[threadIdX + 284 * threadIdY] = cv;
  }
}

static __global__ __launch_bounds__(512, 1) void stereoDisparity_kernel6(int32_T
  d, real_T *cost, int16_T *out_disp, int32_T *min_cost)
{
  uint32_T threadId;
  real_T cv;
  int32_T kk;
  int32_T colIdx;
  int32_T temp_cost;
  ;
  ;
  threadId = ((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
                blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
               threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x)
    + threadIdx.x;
  colIdx = (int32_T)(threadId / 284U);
  kk = (int32_T)(threadId - (uint32_T)colIdx * 284U);
  if ((!(kk >= 284)) && (!(colIdx >= 512))) {
    /*  load the cost */
    cv = cost[kk + 284 * colIdx];
    if (cv < 2.147483648E+9) {
      if (cv >= -2.147483648E+9) {
        temp_cost = (int32_T)cv;
      } else {
        temp_cost = MIN_int32_T;
      }
    } else if (cv >= 2.147483648E+9) {
      temp_cost = MAX_int32_T;
    } else {
      temp_cost = 0;
    }

    /*  compare against the minimum cost available and store the */
    /*  disparity value */
    if (min_cost[kk + 284 * colIdx] > temp_cost) {
      min_cost[kk + 284 * colIdx] = temp_cost;
      out_disp[kk + 284 * colIdx] = (int16_T)((int32_T)fabs(-16.0 + (real_T)d) +
        8);
    }
  }
}

void stereoDisparity(const uint8_T img0[581632], const uint8_T img1[581632],
                     int16_T out_disp[145408])
{
  int32_T d;
  int16_T *gpu_out_disp;
  int32_T *gpu_min_cost;
  uint8_T *gpu_img1;
  uint8_T *gpu_img0;
  int32_T *gpu_diff_img;
  int32_T *gpu_a;
  real_T *gpu_cost_v;
  real_T *gpu_cost;
  boolean_T img1_dirtyOnCpu;
  boolean_T img0_dirtyOnCpu;
  cudaMalloc(&gpu_min_cost, 581632ULL);
  cudaMalloc(&gpu_out_disp, 290816ULL);
  cudaMalloc(&gpu_cost, 1163264ULL);
  cudaMalloc(&gpu_cost_v, 1228800ULL);
  cudaMalloc(&gpu_a, 633600ULL);
  cudaMalloc(&gpu_diff_img, 633600ULL);
  cudaMalloc(&gpu_img0, 581632ULL);
  cudaMalloc(&gpu_img1, 581632ULL);
  img1_dirtyOnCpu = true;
  img0_dirtyOnCpu = true;

  /*  modified algorithm for stereo disparity block matching */
  /*  In this implementation instead of finding shifted image ,indices are mapped accordingly */
  /*  to save memory and some processing RGBA column major packed data is used as input for */
  /*  Compatibility with CUDA intrinsics Convolution is performed using separable filters (Horizontal and then Vertical) */
  /*  gpu code generation pragma */
  /*  Stereo disparity Parameters */
  /*  WIN_RAD is the radius of the window to be operated,min_disparity is the minimum disparity level  */
  /*  the search continues max_disparity is the maximun disparity level the search continues */
  /*  Image dimensions for loop control */
  /*  The number of channels packed are 4 (RGBA) so as nChannels are 4 */
  /*  To store the raw differences */
  /* To store the minimum cost */
  /*  Store the final disparity */
  stereoDisparity_kernel1<<<dim3(284U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_out_disp, gpu_min_cost);

  /*  Filters for aggregating the differences */
  /*  filter_h is the horizontal filter used in separable convolution */
  /*  filter_v is the vertical filter used in separable convolution which */
  /*  operates on the output of the row convolution */
  /*  Main Loop that runs for all the disparity levels. This loop is */
  /*  expected to run on CPU. */
  for (d = 0; d < 17; d++) {
    /*  Find the difference matrix for the current disparity level. Expect */
    /*  this to generate a Kernel function. */
    if (img1_dirtyOnCpu) {
      cudaMemcpy((void *)gpu_img1, (void *)&img1[0], 581632ULL,
                 cudaMemcpyHostToDevice);
      img1_dirtyOnCpu = false;
    }

    if (img0_dirtyOnCpu) {
      cudaMemcpy((void *)gpu_img0, (void *)&img0[0], 581632ULL,
                 cudaMemcpyHostToDevice);
      img0_dirtyOnCpu = false;
    }

    stereoDisparity_kernel2<<<dim3(310U, 1U, 1U), dim3(512U, 1U, 1U)>>>(gpu_img1,
      gpu_img0, d, gpu_diff_img);

    /*  Aggregating the differences using separable convolution. Expect this to generate two Kernel */
    /*  using shared memory.The first kernel is the convolution with the horizontal kernel and second */
    /*  kernel operates on its output the column wise convolution. */
    stereoDisparity_kernel3<<<dim3(310U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (gpu_diff_img, gpu_a);
    stereoDisparity_kernel4<<<dim3(10U, 16U, 1U), dim3(32U, 32U, 1U)>>>(gpu_a,
      gpu_cost_v);
    stereoDisparity_kernel5<<<dim3(9U, 16U, 1U), dim3(32U, 32U, 1U)>>>
      (gpu_cost_v, gpu_cost);

    /*  This part updates the min_cost matrix with by comparing the values */
    /*  with current disparity level. */
    stereoDisparity_kernel6<<<dim3(284U, 1U, 1U), dim3(512U, 1U, 1U)>>>(d,
      gpu_cost, gpu_out_disp, gpu_min_cost);
  }

  cudaMemcpy((void *)&out_disp[0], (void *)gpu_out_disp, 290816ULL,
             cudaMemcpyDeviceToHost);
  cudaFree(gpu_img1);
  cudaFree(gpu_img0);
  cudaFree(gpu_diff_img);
  cudaFree(gpu_a);
  cudaFree(gpu_cost_v);
  cudaFree(gpu_cost);
  cudaFree(gpu_out_disp);
  cudaFree(gpu_min_cost);
}

/* End of code generation (stereoDisparity.cu) */
