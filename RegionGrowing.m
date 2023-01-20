I=imread('C:\Users\shaad\Downloads\ctlung.jpg'); %Image read command use rgb2gray if not grayscale
%I=rgb2gray(I);
figure,subplot(2,1,1);
imshow(I);
title('Input seed for region growing segmentation');
[x, y]=ginput(1); % seed pixel selection by user
x=uint8(x);         % Converting inputs to uint8 as ginput gives pixel coordinates in double format
y=uint8(y);
F=zeros(size(I,1), size(I,2));     % Segmented image initialized as matrix of zeroes with original image size
a='Y';                  % Segmentation condition initilialized as 'Y' to begin
while(a=='Y')           % Loop to keep implementing the segmentation process till the user wishes
    S=regiongrow(I,x,y);    % Designed Segmentation function called
    F=F+S;                  % Adding Segmentation results
    subplot(2,1,1);
    imshow(I);
    title('Original Image');
    subplot(2,1,2);
    imshow(F);
    title('Segmented Image');
    prompt = "Continue segmentation? Y/N [Y]: ";
    a = input(prompt,"s");  %Ask user to input decision to continue segmentation
    if a=='Y'
        figure,imshow(I);
        [x,y]=ginput(1);    %Choosing another seed for segmentation
        x=uint8(x);         
        y=uint8(y);
    end
end
%% Region Growing Function definition
function [S]=regiongrow(I,x,y)      
seed = I(x,y); %value of the seed pixel selected
%mask = [-1 -1; -1 0; -1 1; 1 0; 0 -1; 0 1; 1 -1; 1 1]; % mask to get eight neighbouring  pixels
mask = [-1 0; 1 0; 0 -1; 0 1];            % mask to get four neighbour pixels
pixseg = zeros(size(I,1)*size(I,2), 2); % array to put the segmented pixel coordinates 
pixseg(1, :) = [x, y]; % seed pixel coordinates entered in the array
S = zeros(size(I,1), size(I,2)); % Blank segmented image which will be populated with the algorithm
t = 10; % Threshold parameter for segmentation
seedin = 1; %Initial seed number
seedn = 1;  % Next seed number initially set to 1
flag=1; % flag set for looping
while(flag==1)
        for i=seedin:seedn % loop to iterate for number of seeds
            for j=1:4 % loop to iterate over neighbouring pixels if mask with 8 neighbours used change 4 to 8 in the loop
                xn = x + mask(j,1); %Checking neighbouring pixels
                yn = y + mask(j,2);
                check=(xn-1>1)&&(yn-1>1)&&(xn+1<=size(I,1))&&(yn+1<=size(I,2));% check if neighbour pixel has valid position in image
                seed = I(xn,yn);
                if(check && abs(seed-I(x,y))<=t && (S(xn, yn)==0))% condition check for pixel to be in image, satisifies segmentation condition and not previously added to the segmented image already
                    seedn = seedn+1; % Increase count for the next neighbour seed pixel to iterate further
                    pixseg(seedn, :) = [xn, yn]; %add the neighbour pixel
                    S(xn,yn) = 255; % Segmented pixel added as white pixel
                end
            end
        end
        if(seedn == seedin)
             flag = 0; % if no neighbours are added in pass flag is set to zero
        else
            seedin = seedin+1;
            x = pixseg(seedin, 1, :);
            y = pixseg(seedin, 2, :); % Assigning the next neighbour as the central seed to iterate again
            flag = 1; %keep running the loop
        end
end
end

