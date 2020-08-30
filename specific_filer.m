
RGB = imread('mypc.jpg');

A = rgb2gray(RGB);

RGB2 = imread('mypc.jpg');

B = rgb2gray(RGB2);
Kernel_1 = (1/9)*ones(3);
Kernel_2 = (1/49)*ones(7);
Kernel_3 = fspecial('average',7);
Kernel_4 = fspecial('gaussian',[3,3],0.5);
Kernel_5 = fspecial('gaussian',[7,7],1.2);
   
K1_img_out_filter = imfilter(A,Kernel_1);
K2_img_out_filter = imfilter(A,Kernel_2);
K3_img_out_filter= imfilter(A,Kernel_3);
K4_img_out_filter= imfilter(A,Kernel_4);
K5_img_out_filter= imfilter(A,Kernel_5);
figure
imshow(RGB);title('img1')
figure
imshow(A); title('grayimage')
figure
imshow(K1_img_out_filter);  title('filerKernel-1')
figure
imshow(K2_img_out_filter);  title('filerKernel-2')
figure
imshow(K3_img_out_filter);  title('filerKernel-3')
figure
imshow(K4_img_out_filter);  title('filerKernel-4')
figure
imshow(K5_img_out_filter);  title('filerKernel-5')

K33 = medfilt2(A,[3,3]);
K55 = medfilt2(A,[5,5]);
figure
imshow(K33);  title('Kernel Median filter 3*3')
figure
imshow(K55);  title('Kernel Median filter 5*5')

Kernel_6=[-1,0,1:-2 0 2:-1 0 1];
K6_img_out_filter= imfilter(B,Kernel_6);
figure
imshow(K6_img_out_filter);  title('Kernel-6')
Kernel_7=[-1,-2,-1:0 0 0:1 2 1];
K7_img_out_filter= imfilter(B,Kernel_7);
figure
imshow(K7_img_out_filter);  title('Kernel-7')
Kernel_8 = fspecial('log',3);
K8_img_out_filter= imfilter(B,Kernel_8);
figure
imshow(K8_img_out_filter);  title('Kernel-8')
