@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=stereoDisparity_mex
set MEX_NAME=stereoDisparity_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for stereoDisparity > stereoDisparity_mex.mki
echo COMPILER=%COMPILER%>> stereoDisparity_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> stereoDisparity_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> stereoDisparity_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> stereoDisparity_mex.mki
echo LINKER=%LINKER%>> stereoDisparity_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> stereoDisparity_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> stereoDisparity_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> stereoDisparity_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> stereoDisparity_mex.mki
echo BORLAND=%BORLAND%>> stereoDisparity_mex.mki
echo NVCC=nvcc >> stereoDisparity_mex.mki
echo CUDA_FLAGS= -c -rdc=true -Xcompiler "/wd 4819" -Xcudafe "--diag_suppress=unsigned_compare_with_zero --diag_suppress=useless_type_qualifier_on_return_type" -D_GNU_SOURCE -DMATLAB_MEX_FILE >> stereoDisparity_mex.mki
echo LD=nvcc >> stereoDisparity_mex.mki
echo MAPLIBS=libemlrt.lib,libcovrt.lib,libut.lib,libmwmathutil.lib,/export:mexFunction,/export:emlrtMexFcnProperties,/export:stereoDisparity,/export:stereoDisparity_initialize,/export:stereoDisparity_terminate,/export:stereoDisparity_atexit >> stereoDisparity_mex.mki
echo OMPFLAGS= >> stereoDisparity_mex.mki
echo OMPLINKFLAGS= >> stereoDisparity_mex.mki
echo EMC_COMPILER=msvc140>> stereoDisparity_mex.mki
echo EMC_CONFIG=optim>> stereoDisparity_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f stereoDisparity_mex.mk
