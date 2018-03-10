clc;
clear all;




addpath('.\commun');
addpath('.\_adam');
addpath('.\_andrea');
addpath('.\_mariann');

I_gradient = prepareColorGradient(strcat('.\resources\','gradient_color','.jpg'));
globalData = struct('is_active',0, 'vid_color', [], 'vid_depth', [], 'i_gradient', I_gradient);



MenuGUI(globalData);

clear all;








