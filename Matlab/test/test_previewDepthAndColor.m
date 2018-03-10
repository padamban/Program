% Peter Adam Bankuti - 2018.03.02.
% Testing kinect color and depth image preview.

clc
clear all

kinectDeviceInfo = imaqhwinfo('kinect')

colorDevice = kinectDeviceInfo.DeviceInfo(1)
colorVid = videoinput('kinect',1)

depthDevice = kinectDeviceInfo.DeviceInfo(2)
depthVid = videoinput('kinect',2)

preview([colorVid depthVid]);










pause (6);
delete(colorVid);
delete(depthVid);





