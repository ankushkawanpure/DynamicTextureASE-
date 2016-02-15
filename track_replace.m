foregroundDetector = vision.ForegroundDetector('NumGaussians', 3, ...
    'NumTrainingFrames', 50);
videoReader = vision.VideoFileReader('vid.avi');
for i = 4:70
    frame = step(videoReader); 
    foreground = step(foregroundDetector, frame);
        if i>55
            se = strel('square', 3);
filteredForeground = imopen(foreground, se);

            blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, ...
    'MinimumBlobArea', 150);
bbox = step(blobAnalysis, filteredForeground);
bbox(1,1)=bbox(1,1)-5;
bbox(1,2)=bbox(1,2)-5;
bbox(1,3)=bbox(1,3)+15;
bbox(1,4)=bbox(1,4)+15;
result = insertShape(frame, 'Rectangle', bbox, 'Color', 'red');
figure; imshow(result); title('Detected objects');
            
        end
    
end
figure; imshow(frame); title('Video Frame');
 figure; imshow(foreground); title('Foreground');


se = strel('square', 3);
filteredForeground = imopen(foreground, se);
figure; imshow(filteredForeground); title('Foreground After Removing noise');

blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, ...
    'MinimumBlobArea', 150);
bbox = step(blobAnalysis, foreground);

result = insertShape(frame, 'Rectangle', bbox, 'Color', 'red');

figure; imshow(result); title('Detected objects');

% rec1[x,y,w,h]=Ibox(:,cnt);
   
 % cur=imcrop(img,rec);
 
 %bbox(1,1)
%    cur= imcrop(result,bbox(:,1));
%    subplot(2,1,2); imshow(cur);