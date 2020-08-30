% Xuchen Sun  201893438
 

imc = imread('hu.jpg');
% load the image
img = rgb2gray(imc); %gray scale
imshow(img);% view the image
 
f2=im2double(img)/255;
f2=power(f2,0.5);
figure,
imshow(f2,[]);