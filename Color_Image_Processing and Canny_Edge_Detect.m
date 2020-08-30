
I = imread('mypc.jpg');    % read
figure(11);                     % creat window
imshow(I);title('Original');  % display name
figure(12);
subplot(1,2,1);             % Display Histogram without seperation
imhist(I);title('Histogram without seperation');
subplot(1,2,2);             % Display Histogram with 64 part
imhist(I,64);title('Histogram and seperated to 64 parts');


I = imread('mypc.jpg');    % read image
figure;                      
[M,N] = size(I);            %  get size
[counts,x] = imhist(I,32);  % calculate the
counts = counts/(M*N);      % Calculate the value of normalized gray histogram 
stem(x,counts);             % output result

rgb = im2double(I); 
r = rgb(:, :, 1); 
g = rgb(:, :, 2); 
b = rgb(:, :, 3); 
 
% achieve the function
num = 0.5*((r - g) + (r - b)); 
den = sqrt((r - g).^2 + (r - b).*(g - b)); 
theta = acos(num./(den + eps)); % prevent O 
 
H = theta; 
H(b > g) = 2*pi - H(b > g); 
H = H/(2*pi); 
 
num = min(min(r, g), b); 
den = r + g + b; 
den(den == 0) = eps; %prevent ) 
S = 1 - 3.* num./den; 
 
H(S == 0) = 0; 
 
I = (r + g + b)/3; 
 
% combine three value into a new image. 
hsi = cat(3, H, S, I); 
figure; 
imshow(hsi);title('HSL:hue,saturation,brightness');

  
imgsrc = imread('mypc.jpg');
[y, x, dim] = size(imgsrc);

%chang image into grayscle
if dim>1
    imgsrc = rgb2gray(imgsrc);
end

sigma = 1;
gausFilter = fspecial('gaussian', [3,3], sigma);
img= imfilter(imgsrc, gausFilter, 'replicate');

zz = double(img);


 %use edge detectiong function
 [m theta sector canny1  canny2 bin] = canny1step(img, 22);
  [msrc thetasrc sectorsrc c1src  c2src binsrc] = canny1step(imgsrc, 22);
 %Matlab edge detect functin edge
 ed = edge(img, 'canny', 0.5); 
 
 
[xx, yy] = meshgrid(1:x, 1:y);

figure(21)
    %mesh(yy, xx, zz);
    surf(yy, xx, zz);
    xlabel('y');
    ylabel('x');
    zlabel('Grayscale');
    axis tight

figure(22)    
    subplot(4,2,1);
        imshow(imgsrc);title('Original');%original
    subplot(4,2,2);
        imshow(img);title('Gaussian filtering');%Gaussian filtering
    subplot(4,2,3);
        imshow(uint8(m));title('Derivative function');% Derivative function
    subplot(4,2,4);
        imshow(uint8(canny1));title('Non-maximum suppression');%Non-maximum suppression
    subplot(4,2,5);
        imshow(uint8(canny2));title('Dual threshold');%Dual threshold
    subplot(4,2,6);
        imshow(ed);title('Matlab self edge detect');%Matlab self edge detect
 
    

    
function hsi = rgb2hsi(rgb)


% Extract image components
rgb = im2double(rgb);
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);

% achieve the function(2)(3)(4)(5)
num = 0.5*((r - g) + (r - b));
den = sqrt((r - g).^2 + (r - b).*(g - b));
theta = acos(num./(den + eps)); 

H = theta;
H(b > g) = 2*pi - H(b > g);
H = H/(2*pi);

num = min(min(r, g), b);
den = r + g + b;
den(den == 0) = eps; 
S = 1 - 3.* num./den;

H(S == 0) = 0;

I = (r + g + b)/3;

% combine three into a new HSI image
hsi = cat(3, H, S, I);
end


    
    function [ m, theta, sector, canny1,  canny2, bin] = canny1step( src,  lowTh)
%canny step one?Find the partial derivative function in x and y directions




[Ay Ax dim ] = size(src);
%change into grayscale
if dim>1
    src = rgb2gray(src);
end


src = double(src);
m = zeros(Ay, Ax); 
theta = zeros(Ay, Ax);
sector = zeros(Ay, Ax);
canny1 = zeros(Ay, Ax);%Non-maximum suppression
canny2 = zeros(Ay, Ax);%Dual threshold detect and connect
bin = zeros(Ay, Ax);
for y = 1:(Ay-1)
    for x = 1:(Ax-1)
        gx =  src(y, x) + src(y+1, x) - src(y, x+1)  - src(y+1, x+1);
        gy = -src(y, x) + src(y+1, x) - src(y, x+1) + src(y+1, x+1);
        m(y,x) = (gx^2+gy^2)^0.5 ;
        %--------------------------------
        theta(y,x) = atand(gx/gy)  ;
        tem = theta(y,x);
        %--------------------------------
        if (tem<67.5)&&(tem>22.5)
            sector(y,x) =  0;    
        elseif (tem<22.5)&&(tem>-22.5)
            sector(y,x) =  3;    
        elseif (tem<-22.5)&&(tem>-67.5)
            sector(y,x) =   2;    
        else
            sector(y,x) =   1;    
        end
        %--------------------------------        
    end    
end
%-------------------------
%Non-maximum suppression
%------> x
%   2 1 0
%   3 X 3
%y  0 1 2
for y = 2:(Ay-1)
    for x = 2:(Ax-1)        
        if 0 == sector(y,x) %right top - left bottom
            if ( m(y,x)>m(y-1,x+1) )&&( m(y,x)>m(y+1,x-1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 1 == sector(y,x) %Vertically
            if ( m(y,x)>m(y-1,x) )&&( m(y,x)>m(y+1,x)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 2 == sector(y,x) %left top - right down
            if ( m(y,x)>m(y-1,x-1) )&&( m(y,x)>m(y+1,x+1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 3 == sector(y,x) %horizontal direction
            if ( m(y,x)>m(y,x+1) )&&( m(y,x)>m(y,x-1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        end        
    end%end for x
end%end for y

%---------------------------------
%Dual threshold detection
ratio = 2;
for y = 2:(Ay-1)
    for x = 2:(Ax-1)        
        if canny1(y,x)<lowTh %Low threshold processing
            canny2(y,x) = 0;
            bin(y,x) = 0;
            continue;
        elseif canny1(y,x)>ratio*lowTh %high threshold processing
            canny2(y,x) = canny1(y,x);
            bin(y,x) = 1;
            continue;
        else %judge if the value is ok , then set it as edge
            tem =[canny1(y-1,x-1), canny1(y-1,x), canny1(y-1,x+1);
                       canny1(y,x-1),    canny1(y,x),   canny1(y,x+1);
                       canny1(y+1,x-1), canny1(y+1,x), canny1(y+1,x+1)];
            temMax = max(tem);
            if temMax(1) > ratio*lowTh
                canny2(y,x) = temMax(1);
                bin(y,x) = 1;
                continue;
            else
                canny2(y,x) = 0;
                bin(y,x) = 0;
                continue;
            end
        end
    end%end for x
end%end for y
end

    
    
