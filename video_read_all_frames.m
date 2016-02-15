%This function reads all the frames in the video and saves it in
%mov_video_name structure


VidData=VideoReader('ankush2.mp4');

nFrames = VidData.NumberOfFrames;
vidHeight = VidData.Height;
vidWidth = VidData.Width;
k=0;

      
       
     mov_object(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []); 
 
       
       
   
for k = 1 : nFrames
        mov_object(k).cdata = read(VidData, k);
        
end
    
%this part is for saving the frames
k=1;

 
 for k=1:185
     imwrite(mov_object(k).cdata,fname);
     fname=sprintf('vidn%d.png',k);
 end
 
 
      
% writerObj = VideoWriter('replaced_car.avi');
% writerObj.FrameRate=25;
% open(writerObj);
% writeVideo(writerObj,mov_object);
% close(writerObj);


%to create image write command imwrite(mov(i).cdata,'file.png')

%where i is the frame number
