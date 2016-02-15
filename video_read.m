VidData=VideoReader('bear_source.avi');

nFrames = VidData.NumberOfFrames;
vidHeight = VidData.Height;
vidWidth = VidData.Width;
k=0;

mov_edit(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
       
       
       
     mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []); 
 
       
       
     mov_output(1:150) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
 
for k = 1 : nFrames
        mov(k).cdata = read(VidData, k);
end
    
       
       
for k = 1 : nFrames
    mov_edit(k).cdata = read(VidData, k);
    
    x=46;
    y=220;
while x<80
    y=220;
    while y<240
        mov_edit(k).cdata(x,y,:)=[0,0,0];
        y=y+1;
    end
    x=x+1;
end
end
jx=5;
for jx = 5 : 149
    imwrite(mov(jx).cdata,'input.png');
    imwrite(mov_edit(jx).cdata,'input_mask.png');
    inpainted;
   mov_output(jx).cdata=imread('Inpainted.jpg');
end
movie(mov_output)
