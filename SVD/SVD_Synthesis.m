function [PsnrSvdRgb, CostSvdRgb] = SVD_Synthesis(TextName,Coordinates, Zoom, Nrgb,SaveVideo)

%This Function is used to Synthesize & calculate the no of model coefficients ie cost
%factor and PSNR for SVD Algorithm
%TextName:name of the dynamic texture;
%Coordinates:coordinates of the portion of the image
%Zoom:Zoom factor to apply to the images;
%Nrgb:temporal order of the model ie Nrgb= 5:5:tau-5
%This  Function returns Average prediction error and no of model
%coefficients ie PsnrSvdRgb & CostSvdRgb: number of model coefficients

FirstRow =Coordinates(1);
LastRow =Coordinates(2);
FirstColumn =Coordinates(3);
LastColumn =Coordinates(4);

load([  'D:/Database/D_SVD_RGB_',TextName,'_',num2str(FirstRow),'x',num2str(LastRow),'x',...
    num2str(FirstColumn),'x',num2str(LastColumn),'_Zoom',num2str(Zoom),'.mat']);
%load decompose parameters from Database
Nvrgb = round(Nrgb/3*2);   % Nrgb 5 to tau-5
tic
mov(1:tau-1) = ...
    struct('cdata', zeros(LastRow+1, LastColumn+1, 3, 'uint8'),...
    'colormap', []);


for j = 1:length(Nrgb) %j 1 to lenght(Nrgb)
    
    n_rgb = Nrgb(j);    %copy 5:10:Tau-5 to n_rgb
    nv_rgb = Nvrgb(j);   %copy 3,7,10...  to nv_rgb
    first = 1:n_rgb;          % 1 to -- n_rgb
    
    Chat_rgb = U(:,first);   %Collecting 1 to first  column of U
    Xhat_rgb = S(first,first)*V(:,first)'; %collecting first n column of V and first n diagonal elments of of S get Product term
    X1 = Xhat_rgb(:,1:tau-1);
    X2 = Xhat_rgb(:,2:tau);
    Ahat_rgb = X2*pinv(X1);   %Moore-Penrose pseudoinverse of a matrix
    
    for k = 2:tau             %1 to tau-1
        X_rgb = Ahat_rgb*Xhat_rgb(:,k-1);
        Y_rgb_synth = Chat_rgb*X_rgb+Amean;  %+Amean This is the formula for synthesis ie yk=Cxk + d
        
        MSE_rgb = mse( Srgb(:,k) - Y_rgb_synth ); %to find MSE(Original rgb frame - predicted rgb frame)
        PsnrSvdRgb(j,k-1) = 10*log10( (255^2) / MSE_rgb); % Average value of the PEAK Signal to Noise Ratio(PSNR)-Average Prediction error.
        %17 by 88 for flame
        imshow(uint8(reshape(Y_rgb_synth,x,y,z)));
        
        frame_image=getframe;
        mov(k).cdata=frame_image.cdata;
    end
    
    CostSvdRgb(j) = prod(size(Ahat_rgb)) + prod(size(Chat_rgb)) + prod(size(Amean))+nv_rgb*n_rgb ;% number of model coefficients for 1 to tau-5 (ie 5 10 15 ...)
    
end

writerObj = VideoWriter(SaveVideo);
writerObj.FrameRate=28;
open(writerObj);
writeVideo(writerObj,mov);
close(writerObj);

% movie2avi(mov,'after_speed.avi','FPS',25);

toc
save([  'D:/Database/CP_SVD_RGB_',TextName,'_',num2str(FirstRow),'x',num2str(LastRow),'x',...
    num2str(FirstColumn),'x',num2str(LastColumn),'_Zoom',num2str(Zoom),'.mat'],...
    'PsnrSvdRgb', 'CostSvdRgb',  'Nrgb');
%store PSNR,COST,Nrgb values in Database.