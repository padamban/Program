function  i_gradient=prepareColorGradient(source_file)

    I_original=imread(source_file);

    gradient_start = 400;
    gradient_size = 1500;
    I_new = imresize(I_original, [1,2000]);

    i_gradient = I_new(1,gradient_start:gradient_start+gradient_size,:);

end