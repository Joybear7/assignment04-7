% Assignment 04 - CEC 495A
% Joy Fucella
% 4 Oct 2017

clc; close all; clear all;

I = imread('envelope3.jpg');
imed = medfilt2(I,[100 100]);
ifinal = imed - I;


Ithresh = ifinal > 90;
SE = strel('disk',4,8);
bw = imopen(Ithresh,SE);
[H,theta,rho] = hough(bw);
P = houghpeaks(H,10);
lines = houghlines(bw,theta,rho,P);

angle = 90 + max([lines.theta]);
Irot = imrotate(I,angle,'crop');
Imed = medfilt2(Irot,[100 100]);
Ifinal = Imed - Irot;
BW = Ifinal > 50;

[m,n] = size(BW);
zoom = BW((2/3*m):m,0:(1/2*n));

SE = strel('disk',4,0);
iopen = imopen(zoom,SE);
iclose = imclose(iopen,SE);
imshow(iclose);
