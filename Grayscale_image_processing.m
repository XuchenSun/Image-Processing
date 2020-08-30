 imc = imread('me.jpg');
% load the image
img = rgb2gray(imc); %gray scale
imshow(img);% view the image
title("Grayscale Image"); 


f2=im2double(img)/255;
f2=power(f2,0.5);
figure,
imshow(f2,[]);
title("Change the grayscale value");