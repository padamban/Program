function []=screenshotGUI( visu,capture, globalData)
    
    ssGUI = figure('NumberTitle', 'off', 'Name', 'Screenshot');
    guidata(ssGUI,globalData);
 
    
    imgs = [];
    
    img_empty = struct('name','I gradient','data',[],'type','img');
    img_gradinet = struct('name','I gradient','data',globalData.i_gradient,'type','img');
    imgs = [imgs; img_gradinet, img_empty;];

    img_normalizedTo255 = struct('name','I depth normalizedTo255','data',visu.normalizedTo255,'type','img');
    img_normalizedTo255_h = struct('name','I depth normalizedTo255','data',visu.normalizedTo255,'type','his');
    imgs = [imgs; img_normalizedTo255, img_normalizedTo255_h;];

    
    img_colored = struct('name','I depth colored','data',visu.colored,'type','img');
    img_colored_h = struct('name','I depth colored','data',capture.color,'type','img');
    imgs = [imgs;  img_colored,img_colored_h ];
    
    
    [row, col] = size(imgs);    

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
%     
%     pause(0.00001);
%     frame_h = get(handle(gcf),'JavaFrame');
%     set(frame_h,'Maximized',1);   
    
    
       assignin('base','capture',capture);   

      isSkeleton = max(size(capture.depth_meta)) ;
       savetxt =  'Save';
       if isSkeleton==0
           savetxt =  'Save (no skeleton)';
       end
      uicontrol('String', savetxt,...
        'Callback', {@save, globalData, capture, ssGUI, isSkeleton},...
        'Units','normalized',...
        'Position',[0 0 0.25 .07]);

    
    

    
end



function save(src,event,globalData, capture, ssGUI, isSkeleton)
   format = 'f1_';
   if isSkeleton == 1
       format = 'f2_';
   end
   kinect_data = struct('fileName',strcat(format,datestr(now,'yyyymmddTHHMMSS'),'.mat'), 'raw', capture) ;
   assignin('base','kinect_data',kinect_data);   
   saveScreenshot;
   close
end











