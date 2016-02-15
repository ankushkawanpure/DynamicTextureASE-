foregroundDetector = vision.ForegroundDetector('NumGaussians', 3, ...
    'NumTrainingFrames', 50);
videoReader = vision.VideoFileReader('old_man_walking_camera.mp4');

VidData=VideoReader('old_man_walking_camera.mp4');

nFrames = VidData.NumberOfFrames;
vidHeight = VidData.Height;
vidWidth = VidData.Width;
k=0;



mov(1:130) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
    'colormap', []);




for i = 1:nFrames
    frame = step(videoReader);
    foreground = step(foregroundDetector, frame);
    if i>300
        se = strel('square', 2);
        filteredForeground = imopen(foreground, se);
        
        blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
            'AreaOutputPort', false, 'CentroidOutputPort', false, ...
            'MinimumBlobArea', 150);
        bbox = step(blobAnalysis, foreground);
        
        result = insertShape(frame, 'Rectangle', bbox, 'Color', 'white');
        
        bbox_size=size(bbox);
        
        size_count=bbox_size(1,1);
        
        if(size_count==1)
            for p=bbox(1):bbox(1)+bbox(3)-1
                for q=bbox(2):bbox(2)+bbox(4)-1
                    if(filteredForeground(q,p)==0)
                        result(q,p,:)=[255];
                    end
                    
                    
                end
            end
        else
            s_count=size_count;
            while(s_count~=0)
                for p=bbox(s_count,1):bbox(s_count,1)+bbox(s_count,3)-1
                    for q=bbox(s_count,2):bbox(s_count,2)+bbox(s_count,4)-1
                        if(filteredForeground(q,p)==0)
                            result(q,p,:)=[255];
                        end
                    end
                end
                s_count=s_count-1;
            end
            
        end
        
        
        
        
        fname=sprintf('Run Images/im%d.jpg',i);
        imwrite(filteredForeground,fname);
    end
   % mov(i).cdata=uint8(result);
    
    if(i>352 && i<425)
        
    end
    
end
%figure; imshow(frame); title('Video Frame');
%figure; imshow(foreground); title('Foreground');



 writerObj = VideoWriter('after_redundant_detected_object.avi');
 open(writerObj);
 writeVideo(writerObj,mov);
 close(writerObj)


% se = strel('square', 3);
% filteredForeground = imopen(foreground, se);
% figure; imshow(filteredForeground); title('Foreground After Removing noise');
%
% blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
%     'AreaOutputPort', false, 'CentroidOutputPort', false, ...
%     'MinimumBlobArea', 150);
% bbox = step(blobAnalysis, foreground);
%
% result = insertShape(frame, 'Rectangle', bbox, 'Color', 'red');
%
% figure; imshow(result); title('Detected objects');

% rec1[x,y,w,h]=Ibox(:,cnt);

% cur=imcrop(img,rec);

%bbox(1,1)
%    cur= imcrop(result,bbox(:,1));
%    subplot(2,1,2); imshow(cur);