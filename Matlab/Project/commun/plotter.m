


function []=plotter(figTitle, imgs)
    [row, col] = size(imgs);    
    
    figure('NumberTitle', 'off', 'Name', figTitle);

    counter = 1;
    for i=1:row
       
       for j=1:col           
            
          subplot(row,col,counter);
                 
          if imgs(i, j).type=='img'
            imshow(imgs(i, j).data);
          elseif imgs(i, j).type=='his'
            imhist(imgs(i, j).data);
          end

          title(imgs(i, j).name)
          
          counter = counter + 1;
       end
    end
    
    pause(0.00001);
    frame_h = get(handle(gcf),'JavaFrame');
    set(frame_h,'Maximized',1);
    
end

