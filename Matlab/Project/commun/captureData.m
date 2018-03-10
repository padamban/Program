function data=captureData(vid_color, vid_depth)

    framesPerTrig  = 20;
     
    depthSource = getselectedsource(vid_depth);
    depthSource.EnableBodyTracking = 'on';

    src_depth = getselectedsource (vid_depth);

    vid_color.FramesPerTrigger = framesPerTrig ;
    vid_depth.FramesPerTrigger = framesPerTrig ;
    triggerRepeat = 1;

    vid_color.TriggerRepeat = triggerRepeat;
    vid_depth.TriggerRepeat = triggerRepeat;

    triggerconfig ([vid_color, vid_depth], 'manual');

    start ([vid_color, vid_depth]);

   
    for i = 1: triggerRepeat
        trigger ([vid_color, vid_depth ])
        [img_color, ts_color, metaData_Color] = getdata (vid_color);
        [img_depth, ts_depth, metaData_Depth] = getdata (vid_depth);
    end
  
    good_metadata = [];
    for i=1:size(metaData_Depth, 1)
       metadata = metaData_Depth(i);
       anyBodiesTracked = any(metadata.IsBodyTracked ~= 0); 
       
       if 1==anyBodiesTracked
            good_metadata = metadata;
           break;
       end
    end
    ts = struct('color', ts_color,'depth', ts_depth);
    data = struct('color', img_color(:,:,:,i), 'depth', img_depth(:,:,1,i), 'depth_meta', good_metadata, 'ts', ts);

end

