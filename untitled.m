clc;
close all;
clear all;

radius=19;%ideali 21 dir
min_area=700;
max_area=2000;

img=im2bw(imread('untitled3.png'));

[imPar]=separateCellsCircular(img,radius, ...
    min_area,max_area);

subplot(2,1,1); imshow(img)
title('Original')
subplot(2,1,2); imshow(imPar)
title('Split')