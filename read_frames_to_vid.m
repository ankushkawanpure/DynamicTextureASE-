% mov_edit(1:nFrames) = ...
%     struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
%            'colormap', []);

mov_edit1(1:139) = ...
    struct('cdata', zeros(240, 320, 3, 'uint8'),...
           'colormap', []);
       
       
       
       for K=1:110
            fname=sprintf('vidn%d.jpg',K);
            mov_edit(K).cdata=imread(fname);
       end
       
       for J=111:139
           fname=sprintf('vid%d.jpg',J);
            mov_edit(J).cdata=imread(fname);
       end
       
       for i=1:139
       mov(i).cdata=mov_edit(i).cdata;
       end
       