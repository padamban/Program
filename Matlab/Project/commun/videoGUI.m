function videoGUI(globalData)

hFigVideo = figure('Toolbar','none',...
       'Menubar', 'none',...
       'NumberTitle','Off',...
       'Name','My Custom Preview GUI');

uicontrol('String', 'Take Screenshot',...
    'Callback', {@takeScreenshotGUI, globalData} ,...
    'Units','normalized',...
    'Position',[0.34 0 .15 .07]);

uicontrol('String', 'Close GUI',...
    'Callback', {@closeGUI, globalData } ,...
    'Units','normalized',...
    'Position',[0.68 0 .15 .07]);

hTextLabel = uicontrol('style','text','String','Timestamp', ...
    'Units','normalized',...
    'Position',[0.85 -.04 .15 .08]);

globalData.vid_depth
vidRes = globalData.vid_depth.VideoResolution;
imWidth = vidRes(1);
imHeight = vidRes(2);
nBands = globalData.vid_depth.NumberOfBands;
hImage = image( zeros(imHeight, imWidth, nBands) );

figSize = get(hFigVideo,'Position');
figWidth = figSize(3);
figHeight = figSize(4);
gca.unit = 'pixels';
gca.position = [ ((figWidth - imWidth)/2)... 
               ((figHeight - imHeight)/2)...
               imWidth imHeight ];

setappdata(hImage,'UpdatePreviewWindowFcn',@mypreview_fcn);

setappdata(hImage,'HandleToTimestampLabel',hTextLabel);

preview(globalData.vid_depth, hImage);

end








function takeScreenshotGUI(src,event,globalData)
    stop([globalData.vid_color globalData.vid_depth]);
    capture = captureData(globalData.vid_color, globalData.vid_depth);
    start([globalData.vid_color globalData.vid_depth]);
    visu = createVisuFromDepth(globalData.i_gradient,capture.depth); 
    screenshotGUI( visu,capture, globalData);
end


function closeGUI(src,event,globalData)
    delete(globalData.vid_color);
    delete(globalData.vid_depth);
    close all;
end



function mypreview_fcn(obj,event,himage)
    tstampstr = event.Timestamp;
    ht = getappdata(himage,'HandleToTimestampLabel');
    ht.String = tstampstr;
    himage.CData = event.Data;
end

