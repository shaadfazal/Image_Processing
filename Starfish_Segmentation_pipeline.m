I=imread('C:\Users\shaad\Desktop\SYSC 5202\Assignments\Assignment 3\Images\Images\starfish.jpg'); %Choose the starfish image to use the image processing pipeline on 
I=imresize(I,0.5); % Resizing image to reduce the computations
figure,subplot(2,3,1);
imshow(I);
title('Starfish Image RGB'); % Original Image
for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j,1)>190 % Thresholding in the Red color matrix of the RGB image
            I(i,j,1)=0;
        else
            I(i,j,1)=255; 
            I(i,j,2)=255; % Saturating the Green and Blue matrix
            I(i,j,3)=255;
        end
       
    end
end
subplot(2,3,2);
imshow(I);
title('Thresholding I RGB'); % Thresholding I result
I=rgb2gray(I); % Grayscale conversion and display
subplot(2,3,3);
imshow(I);
title('Grayscale converted image');
for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j)<90            % Thresholding II
            I(i,j)=0;
        else I(i,j)=255;
        end
    end
end
subplot(2,3,4);
imshow(I);
title('Thresholding II'); % Display image
se=ones(6,1);
iout=imerode(I,se);  % Erosion operation 1
iout=imerode(iout,se); % Erosion 2
subplot(2,3,5);
imshow(iout); % Display result
title('Post erosion image');
sd=[0 1 0; 1 1 1; 0 1 0];
iout=imdilate(iout,sd);     % Dilation
subplot(2,3,6);
imshow(iout);       % Final output image
title('Final output image post dilation');
s=regionprops(iout,"Solidity"); % Computing region properties using MATLAB function
sol=s(255).Solidity;
txt = 'Solidity value obtained %1.4f is greater than threshold selected therefore Starfish detected'; % Text to display in result 
if sol>0.85             % Condition set heuristically of solidity to detect starfish image
    fprintf(txt,sol); 
end

