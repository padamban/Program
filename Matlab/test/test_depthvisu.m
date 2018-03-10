clc
clear all

load('.\test\test.mat');

I_original=imread(strcat('gradient_color','.jpg'));

gradient_start = 400;
gradient_size = 1500;
I_new = imresize(I_original, [1,2000]);

I_gradient = I_new(1,gradient_start:gradient_start+gradient_size,:);


I_depth = test_deptht;

depthSpan = struct('min',min(min(I_depth)),'max',max(max(I_depth)))

I_depth_normalizedTo255 = uint8(double(I_depth)./double(depthSpan.max).*255) + 1;
I_depth_normalizedToGradient = uint16(double(I_depth)./double(depthSpan.max).*gradient_size-2) + 1;

I_depth_colored = uint8(cat(3, zeros(size(I_depth)),zeros(size(I_depth)),zeros(size(I_depth))));

for ii=1:size(I_depth,1)
    for jj=1:size(I_depth,2)
        for rgb=1:3
            color = round(I_gradient(1,I_depth_normalizedToGradient(ii, jj),rgb));
            if I_depth_normalizedToGradient(ii, jj)==1
              color = 0;
            end
            I_depth_colored(ii, jj, rgb) = uint8(color);

        end 
    end
end


depthRegion = struct('min',min(min(test_deptht)),'max',max(max(test_deptht)));




img0G = struct('name','I gradient','data',I_gradient,'type','img')
img0Gh = struct('name','I gradient','data',I_gradient,'type','his')

img00 = struct('name','I depth','data',I_depth,'type','img')
img00h = struct('name','I depth','data',I_depth,'type','his')

img01 = struct('name','I depth normalizedTo255','data',I_depth_normalizedTo255,'type','img')
img01h = struct('name','I depth normalizedTo255','data',I_depth_normalizedTo255,'type','his')

img02 = struct('name','I depth colored','data',I_depth_colored,'type','img')
img02h = struct('name','I depth colored','data',I_depth_colored,'type','his')

plotter('Depth', [img0G, img0Gh;  img01,img01h; img02,img02h  ]);





% pause(15)
% close gcf
% close all

