%% Segmentation for the first MRI T1 weighted brain image
I1=imread('C:\Users\shaad\Desktop\SYSC 5202\Assignments\Assignment 2\A2\MRI_brain.jpg'); %This is RGB image use rgb2gray to convert to grayscale
I1=rgb2gray(I1); 
figure,imshow(I1);
title('Input two diagonal points to implement mask, first should be the top left corner point &  second one is the bottom right corner')
[x,y]=ginput(2) %Input two diagonal points to implement mask, first should be left topmost corner point and other bottowm right corner);
x=uint8(x); % ginput gives pixel coordinates in double format we convert it into uint8
y=uint8(y);
mask=zeros(size(I1));   % Initialize mask with zero matrix of image size 
mask(x(1):x(2),y(1):y(2))=1;        % Mask would be having the desired segmented region in a rectangular shape with logical 1s
seg1=activecontour(I1,mask,300);    % MATLAB inbuilt command to implement region growing snakes method takes input image, mask and number of iterations 
N1=imnoise(I1,"gaussian");      % Gaussian noise mean 0 variance 0.01 added to image
mask=zeros(size(N1));
mask(x(1):x(2),y(1):y(2))=1; %Mask initialization for the noisy image
seg1n=activecontour(N1,mask,300); % Segmentation method applied to noisy image
title('Noisy MRI brain image segmented ventricles');
%% Segmentation for the second MRI T2 weighted brain image
I2=imread('C:\Users\shaad\Desktop\SYSC 5202\Assignments\Assignment 2\A2\MRI_brain2.jpg'); %Image read MATLAb command
figure,imshow(I2);
title('Input two diagonal points to implement mask, first should be the top left corner point &  second one is the bottom right corner')
[x,y]=ginput(2) %Input two diagonal points to implement mask, first should be left topmost corner point and other bottowm right corner);
x=uint8(x);
y=uint8(y);
mask=zeros(size(I2)); % Initialize mask with zero matrix of image size 
mask(x(1):x(2),y(1):y(2))=1; % Mask would be having the desired segmented region in a rectangular shape with logical 1s
seg2=activecontour(I2,mask,300); % MATLAB inbuilt command to implement region growing snakes method takes input image, mask and number of iterations 
N2=imnoise(I2,"gaussian"); % Gaussian noise mean 0 variance 0.01 added to image
mask=zeros(size(N2)); %Mask initialization for the noisy image
mask(x(1):x(2),y(1):y(2))=1;
seg2n=activecontour(N2,mask,300); %Segmentation command applied to noisy image
%% Plotting of segmentation results
figure,subplot(4,2,1);
imshow(I1);
title('a. MRI T1 Image');
subplot(4,2,2);
imshow(I2);
title('b. MRI T2 weighted Image');
subplot(4,2,3);
imshow(seg1);
title('c. MRI T1 Image Segmented');
subplot(4,2,4);
imshow(seg2);
title('d. MRI T2 Image Segmented');
subplot(4,2,5);
imshow(N1);
title('e. MRI T1 Noisy Image');
subplot(4,2,6);
imshow(N2);
title('f. MRI T2 Noisy Image');
subplot(4,2,7);
imshow(seg1n);
title('g. MRI T1 Noisy Image Segmented');
subplot(4,2,8);
imshow(seg2n);
title('h. MRI T2 Noisy Image Segmented');






