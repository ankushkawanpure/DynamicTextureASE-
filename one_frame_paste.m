VidData=VideoReader('lawn_empty.mp4');



      
 
lawn11=mov_lawn(1).cdata;
lawn11=imresize(lawn11,0.3);

nFrames = VidData.NumberOfFrames;
vidHeight = size(lawn11,1);
vidWidth = size(lawn11,2);
k=0;
       
       
     mov_edit(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []); 
  


for x=1:198


lawn11=mov_lawn(x).cdata;
lawn11=imresize(lawn11,0.3);


man11=mov_object(x).cdata;
lawn11=imrotate(lawn11,-90);

object_size=size(man11);

p=1;
q=0;
j=floor(0.4*size(lawn11,2));
i=400;


% lawn11(i:i+object_size(1)-1,j:j+object_size(2)-1,:)=man11;

for i=100:100+object_size(1)-1
   
    q=1;
    for j=floor(0.2*size(lawn11,2)):floor(0.2*size(lawn11,2))+object_size(2)-2
        
        if(man11(p,q,1)>6 &&man11(p,q,2)>6 &&man11(p,q,3)>6)
        lawn11(i,j,:)=man11(p,q,:);
        end
        q=q+1;
    end
     p=p+1;
end

mov_edit(x).cdata=lawn11;
%imshow(lawn11);
end

% while (j<115+object_size(1)-1)
%     p=p+1;
%     q=1;
%     while(i<35+object_size(2)-1)
%     if(man11(p,q,1)==0 && man11(p,q,2)==0 && man11(p,q,3)==0)
%     
%     else
%         
%         lawn11(i,j,:)=man11(p,q,:);
%     end
%     lawn11(i,j,:)=man11(p,q,:);
%     q=q+1;
%     i=i+1;
%     end
%     j=j+1;
% end
