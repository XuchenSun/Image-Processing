
F_rgb=imread('mypc.jpg'); % read the mypc image
F=rgb2gray(F_rgb);
im_size=size(F); 
% Obtain the size of the image
P=2*im_size(1);
Q=2*im_size(2); 
% Optaining padding parametersas 2*image size
FTIm=fft2(double(F),P,Q); 
% FT with padded size
Fim=fftshift(FTIm); 
% move the origin of the FT to the center
FTI=log(1+abs(Fim));

% compute the magnitude (log to brighten display)
subplot(2,2,1), imshow(F,[]), title('Original Image'); 
% show the image
subplot(2,2,2), imshow(FTI,[]), title('FT of Original');
%show the image
