VidData=VideoReader('old_man_walking_camera.mp4');

nFrames = VidData.NumberOfFrames;
vidHeight = VidData.Height;
vidWidth = VidData.Width;
k=0;

      
   totalframes=floor(nFrames/4);    
     mov_object_foreground(1:totalframes) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []); 
 
       
       
   
for k = 1 : totalframes
        
        img= read(VidData, k);
        for i=1:vidHeight
            for j=1:vidWidth
           if img(i,j,:)~=0
               img(i,j,:)=255;
           end
            
            end
        end
        mov_object_foreground(k).cdata=img;
end



movie2avi(mov_object_foreground,'object_after_foreground.avi','FPS',25);