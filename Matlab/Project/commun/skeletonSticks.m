
function sticks=skeletonSticks(img, meta)


    isSkeleton = max(size(meta)) 
    if isSkeleton==1
        
        colors = ['r';'g';'b';'c';'y';'m']
        imshow(img)
        trackedBodies = find(meta.IsBodyTracked);
        nBodies = length(trackedBodies);
        colorJointIndices = meta.ColorJointIndices(:, :, trackedBodies);

        SkeletonConnectionMap = [ [4 3];  % Neck
                          [3 21]; % Head
                          [21 2]; % Right Leg
                          [2 1];
                          [21 9];
                          [9 10];  % Hip
                          [10 11];
                          [11 12]; % Left Leg
                          [12 24];
                          [12 25];
                          [21 5];  % Spine
                          [5 6];
                          [6 7];   % Left Hand
                          [7 8];
                          [8 22];
                          [8 23];
                          [1 17];
                          [17 18];
                          [18 19];  % Right Hand
                          [19 20];
                          [1 13];
                          [13 14];
                          [14 15];
                          [15 16];
                        ];

        for i = 1:24
             for body = 1:nBodies
                 X1 = [colorJointIndices(SkeletonConnectionMap(i,1),1,body) colorJointIndices(SkeletonConnectionMap(i,2),1,body)];
                 Y1 = [colorJointIndices(SkeletonConnectionMap(i,1),2,body) colorJointIndices(SkeletonConnectionMap(i,2),2,body)];
                 line(X1,Y1, 'LineWidth', 1.5, 'LineStyle', '-', 'Marker', '+', 'Color', colors(body));
             end

            hold on;
         end
         hold off;
    end





















end


