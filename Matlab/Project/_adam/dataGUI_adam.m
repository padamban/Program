function dataGUI()
    clc
    clear all
    
    %config
    format = 'f2';
    data_dir = '.\resources\data\';
    
    
    
    
    listing = dir(data_dir);    
    dinfo = dir(data_dir);   
    names_cell = {dinfo.name};    
    
    goodFiles = [];
    for i=1:size(names_cell, 2)
        isOk = contains(names_cell(i), format);
        if isOk==1
            f = strcat(data_dir,names_cell(i));
            goodFiles = [goodFiles;f];
        end
    end
    

    
    i_gradient = prepareColorGradient(strcat('.\resources\','gradient_color','.jpg'));
    
    dGUI = figure('NumberTitle', 'off', 'Name', 'Data gui ADAM');

    

    filename = {goodFiles{1}};

    
    
    dat = struct('subplots', [], 'files', []);
    guidata(dGUI,dat);

    display(filename, i_gradient, dGUI );
 
       
    uicontrol('String', 'Check',...
        'Callback', {@check},...
        'Units','normalized',...
        'Position',[0 0 0.14 .07]);
    filelist = uicontrol('Style', 'popup',...
        'String', goodFiles,...
        'Units','normalized',...
        'Position', [0.15 -0.015 0.50 .07],...
        'Callback', {@selectView,i_gradient});    
    


end


function selectView(src,event,i_gradient )
    filenames = get(src, 'String');
    index = get(src, 'Value');
    selectedFile = filenames(index);
    dat = guidata(src);
    [rowsp, colsp] = size(dat.subplots);    

    for i=1:rowsp       
       for j=1:colsp  
            delete(dat.subplots(i,j))
       end
    end
    
    display(selectedFile, i_gradient, src );
    

    
end


function display(filename,i_gradient, dGUI)


    dat = guidata(dGUI);
    imgs = [];

    data = importdata(filename{1});
    assignin('base','shown_kinect_data',data);   
    

    visu = createVisuFromDepth(i_gradient,data.raw.depth); 

    img_normalizedTo255 = struct('name','I depth normalizedTo255','data',visu.normalizedTo255,'type','img');
    img_normalizedTo255_h = struct('name','I depth normalizedTo255','data',visu.normalizedTo255,'type','his');
    imgs = [imgs; img_normalizedTo255, img_normalizedTo255_h;];
    
    img_colored = struct('name','I depth colored','data',visu.colored,'type','img');
    img_color_skeleton = struct('name','S','data',data.raw.color,'type','ske');
    imgs = [imgs;  img_colored,img_color_skeleton ];
     

    [row, col] = size(imgs);    

    counter = 1;
    
    for i=1:row
       
       for j=1:col           
            
          h = subplot(row,col,counter);
          
          dat.subplots(i,j) = h;  
          if imgs(i, j).type=='img'
            imshow(imgs(i, j).data);

          elseif imgs(i, j).type=='his'
            imhist(imgs(i, j).data);
          elseif imgs(i, j).type=='ske'
%             imshow(imgs(i, j).data);
            skeletonSticks(imgs(i, j).data, data.raw.depth_meta);

          end

          title(imgs(i, j).name);
          
          counter = counter + 1;
       end
    end
    
    
    guidata(dGUI,dat);
    

end




function check(src,event)
    wip = 'TODO'
end