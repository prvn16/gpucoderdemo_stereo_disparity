if isempty(currentFigures), currentFigures = []; end;
close(setdiff(findall(0, 'type', 'figure'), currentFigures))
clear mex
delete *.mexw64
[~,~,~] = rmdir('C:\Sumpurn\gpucoderdemo_stereo_disparity\codegen','s');
clear C:\Sumpurn\gpucoderdemo_stereo_disparity\pack_rgbData.m
delete C:\Sumpurn\gpucoderdemo_stereo_disparity\pack_rgbData.m
clear C:\Sumpurn\gpucoderdemo_stereo_disparity\stereoDisparity.m
delete C:\Sumpurn\gpucoderdemo_stereo_disparity\stereoDisparity.m
delete C:\Sumpurn\gpucoderdemo_stereo_disparity\scene_left.png
delete C:\Sumpurn\gpucoderdemo_stereo_disparity\scene_right.png
clear
load old_workspace
delete old_workspace.mat
delete C:\Sumpurn\gpucoderdemo_stereo_disparity\cleanup.m
cd C:\Sumpurn
rmdir('C:\Sumpurn\gpucoderdemo_stereo_disparity','s');
