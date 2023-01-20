I=imread('C:\Users\shaad\Downloads\mritest.jpg');	% Entering image location to be read by MATLAB function 
I=rgb2gray(I);
[m,n]=size(I);
figure,subplot(1,2,1);
F=abs(fft2(I));
F=fftshift(F);              %Shifting low frequency componenets to centre
imshow(F,[]);
title('Test image in Frequency domain');
subplot(1,2,2);
imshow(I);
title('Test Image in Spatial domain');
H_l=zeros(m,n);
d1=floor(m/2);
d2=floor(n/2);
for i=d1-25:d1+25
    for j=d2-25:d2+25               %Creating low pass filter mask
        H_l(i,j)=1;
    end
end
H_h=ones(m,n);
for i=d1-25:d1+25
    for j=d2-25:d2+25               %Creating High Pass filter mask
        H_h(i,j)=0;
    end
end
F=fft2(I);
F=fftshift(F);
Z_l=F.*H_l;
Z_h=F.*H_h;
figure,subplot(2,2,1);
imshow(uint8(abs(Z_l)));                % 'abs' to convert complex into real components
title('Low pass filtered image in frequency domain');
subplot(2,2,2),imshow(uint8(abs(Z_h)));
title('High pass filtered image in frequency domain');
z_l=abs(ifft2(Z_l));
z_h=abs(ifft2(Z_h));
subplot(2,2,3),imshow(uint8(z_l));
title('low pass filtered image in spatial domain');
subplot(2,2,4),imshow(uint8(z_h));
title('High pass filtered image in spatial domain');


