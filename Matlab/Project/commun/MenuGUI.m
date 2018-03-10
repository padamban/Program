
function MenuGUI(globalData)

    hFig = figure('Menu','none',...
           'Menubar', 'none',...
           'NumberTitle','Off',...
           'Name','My Custom Preview GUI');

    guidata(hFig,globalData);

    uicontrol('String', 'Init Kinect',...
        'Callback', {@initKinect},...
        'Units','normalized',...
        'Position',[0 0.16 0.14 .07]);
    uicontrol('String', 'Close Kinect',...
        'Callback', {@closeKinect},...
        'Units','normalized',...
        'Position',[0.0 0.08 0.14 .07]);
    uicontrol('String', 'Video GUI',...
        'Callback', {@openVideoGUI},...
        'Units','normalized',...
        'Position',[0.0 0 0.14 .07]);

    
   uicontrol('String', 'Data gui - Adam',...
        'Callback', {@openDataGUI, 1},...
        'Units','normalized',...
        'Position',[0.30 0.16 0.20 .07]);
   uicontrol('String', 'Data gui - Andrea',...
        'Callback', {@openDataGUI, 2},...
        'Units','normalized',...
        'Position',[0.30 0.08 0.20 .07]);
   uicontrol('String', 'Data gui - Mariann',...
        'Callback', {@openDataGUI, 3},...
        'Units','normalized',...
        'Position',[0.30 0.00 0.20 .07]);



end


function initKinect(src,event)
    data = guidata(src);

    kinectDeviceInfo = imaqhwinfo('kinect');
    device_color = kinectDeviceInfo.DeviceInfo(1);
    device_depth = kinectDeviceInfo.DeviceInfo(2);
    data.vid_color = videoinput('kinect',1);
    data.vid_depth = videoinput('kinect',2);     
    data.isActive = 1;
    
    guidata(src,data);
end

function closeKinect(src,event)
    data = guidata(src);

    delete(data.vid_color);
    delete(data.vid_depth);
    data.vid_color = [];
    data.vid_depth = [];  
    data.isActive = 0;
    
    guidata(src,data);
    data = guidata(src)
end

function openVideoGUI(src,event)
    initKinect(src,event);
    data = guidata(src);
    
    if 1==data.isActive
        videoGUI(data);
    end
end

function openDataGUI(src,event,id)

    if id == 1
        dataGUI_adam();
    elseif id == 2
%         dataGUI_andrea();
    elseif id == 3
%         dataGUI_mariann();
    end
    
end

