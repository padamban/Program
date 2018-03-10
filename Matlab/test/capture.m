
clc
clear all
function img_data = capture

kinectDeviceInfo = imaqhwinfo('kinect')

device_color = kinectDeviceInfo.DeviceInfo(1)
device_depth = kinectDeviceInfo.DeviceInfo(2)

vid_color = videoinput('kinect',1)
vid_depth = videoinput('kinect',2)


src_depth = getselectedsource (vid_depth);


vid_color.FramesPerTrigger = 1;
vid_depth.FramesPerTrigger = 1;
trigger_count = 5;

vid_color.TriggerRepeat = trigger_count;
vid_depth.TriggerRepeat = trigger_count;

triggerconfig ([vid_color, vid_depth], 'manual');

start ([vid_color, vid_depth]);


for i = 1: trigger_count
    trigger ([vid_color, vid_depth ])
    [imgColor, ts_color, metaData_Color] = getdata (vid_color);
    [imgDepth, ts_depth, metaData_Depth] = getdata (vid_depth);
end

% preview([vid_color vid_depth]);











delete(vid_color);
delete(vid_depth);


