% Peter Adam Bankuti - 2018.03.02.
% Test the ploting of the colored point cloud from Kinect

clc
clear all

colorDevice = imaq.VideoDevice('kinect',1)
depthDevice = imaq.VideoDevice('kinect',2)

colorDevice();
depthDevice();

 colorImage = colorDevice();
  depthImage = depthDevice();

ptCloud = pcfromkinect(depthDevice, depthImage, colorImage);

% Initialize a player to visualize 3-D point cloud data. The axis is
% set appropriately to visualize the point cloud from Kinect.
player = pcplayer(ptCloud.XLimits, ptCloud.YLimits, ptCloud.ZLimits,...
              'VerticalAxis', 'y', 'VerticalAxisDir', 'down');

xlabel(player.Axes, 'X (m)');
  ylabel(player.Axes, 'Y (m)');
  zlabel(player.Axes, 'Z (m)');

  % Acquire and view Kinect point cloud data.
  while isOpen(player)
     colorImage = colorDevice();
     depthImage = depthDevice();

     ptCloud = pcfromkinect(depthDevice, depthImage, colorImage);

     view(player, ptCloud);
  end
  
  
release(colorDevice);
release(depthDevice);