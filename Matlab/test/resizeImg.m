fileName = 'gradient_color';
format = '.jpg';
I_original=imread(strcat(fileName,format));

size(I_original)
I_new = imresize(I_original, [1,255]);
size(I_new)

I_original_visu = struct('name',size(I_original),'data',I_original,'type','img')
I_new_visu = struct('name',size(I_new),'data',I_new,'type','img')

plotter('New image', [I_original_visu;I_new_visu]);