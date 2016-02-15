%trying to calculate SVD of the given video and speed up the video
function [U,S,V]= SVD_reverse(TextName, Coordinates, Zoom)

% This function is used to decomposes the input data according to SVD algorithm
% (RGB)   
%TextName:  name of the dynamic texture;                             
%Coordinates-  Width by Height
%Zoom- Zoom factor used to Zoom in images; 
%This Function returns Decomposition matrices-[U,S,V]     
                                          
name = [TextName,'.avi']; %to assign name to avi file
p =aviinfo(name)          % to get information of avi file 

FirstRow = Coordinates(1) %First Height coordinate
LastRow = Coordinates(2)  %last Height coordinate 
FirstColumn = Coordinates(3) %First Width coordinate
LastColumn = Coordinates(4)  %last Width coordinate

mov = aviread(name); % mov = aviread(filename) reads the AVI movie filename into the MATLAB movie structure mov. 
tau = length(mov);   % Store no of frames in tau variable.
im = getfield(mov,{1,1},'cdata'); %Get field of structure array
[x y z] = size(imresize(im(FirstRow:LastRow,FirstColumn:LastColumn,:),1/Zoom));% Resize Image into 1/ZOOM times original Image and stored size in x y z

tic            %tic starts a stopwatch timer.
for i = 1:tau   %For loop is used for all frames
    im = getfield(mov,{1,i},'cdata');
    TempMat = double(imresize(im(FirstRow:LastRow,FirstColumn:LastColumn,:),1/Zoom));  % returns an image that is 1/Zoom times the size of Image.& Convert to double precision
    imshow(uint8(TempMat)); %Unit8 convert to unsigned  8 bit integer
    getframe;           %getframe returns a movie frame. The frame is a snapshot (pixmap) of the current axes or figure. 
    Srgb(:,i) = TempMat(:); %Convert in to column vector
end

Amean = mean(Srgb,2); %d-Vector to store  the average mean values of the elements along different dimensions of an array. 

[U,S,V] = svd(Srgb-Amean*ones(1,size(Srgb,2)),0); %The svd command computes the matrix singular value decomposition.

%%
%This is my addition trying to speed up the video a bit by factor seek
seek=-2;

V=V*seek;



%%


toc     %prints the elapsed time since tic was used. 
save([  'D:/Database/D_SVD_RGB_',TextName,'_',num2str(FirstRow),'x',num2str(LastRow),'x',...
        num2str(FirstColumn),'x',num2str(LastColumn),'_Zoom',num2str(Zoom),'.mat'],...
        'U', 'S', 'V', 'Srgb', 'Amean','x','y','z','tau');
         
        %Save Parameters in Daabase
        
        
        
        
        
        