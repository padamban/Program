function  visu=createVisuFromDepth(i_gradient, i_depth)
    
    depthSpan = struct('min',min(min(i_depth)),'max',max(max(i_depth)));

    i_depth_normalizedTo255 = uint8(double(i_depth)./double(depthSpan.max).*255) + 1;
    i_depth_normalizedToGradient = uint16(double(i_depth)./double(depthSpan.max).*size(i_gradient,2)-2) + 1;

    i_depth_colored = uint8(cat(3, zeros(size(i_depth)),zeros(size(i_depth)),zeros(size(i_depth))));

    for ii=1:size(i_depth,1)
        for jj=1:size(i_depth,2)
            for rgb=1:3
                color = round(i_gradient(1,i_depth_normalizedToGradient(ii, jj),rgb));
                if i_depth_normalizedToGradient(ii, jj)==1
                  color = 0;
                end
                i_depth_colored(ii, jj, rgb) = uint8(color);
            end 
        end
    end
        

    visu = struct('normalizedTo255', i_depth_normalizedTo255, 'normalizedToGradient',i_depth_normalizedToGradient, 'colored',i_depth_colored);
end