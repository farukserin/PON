clc;
close all;
clear all;

img=imread('a-1-10.jpg');

kClusters=5;
radius=4;
divisionRate=1;
min_area=25;
max_area=120;
min_area_resized=round(min_area/divisionRate^2);
max_area_resized=round(max_area/divisionRate^2);

length_h=size(img,1);
length_v=size(img,2);
length_h_resized=round(length_h/divisionRate);
length_v_resized=round(length_v/divisionRate);

[segmntdImgs]=kmeans_segmentation(img, kClusters);

[binary_nuclei_k]=findClusterOfNuclei(img,segmntdImgs, kClusters);

imResNuc_k=imresize(logical(binary_nuclei_k),[length_h_resized,length_v_resized]);
[imResMinRemoval]=ds(imResNuc_k, min_area_resized);

[imReMax]=ds(imResMinRemoval,max_area_resized);
imApr=logical(imsubtract(imResMinRemoval,imReMax));

[imPar]=separateCellsCircular(imReMax,radius, ...
    min_area_resized,max_area_resized);

imPar=logical(imadd(imApr,imPar));

imRep=imresize(imPar, [length_h, length_v]);

[imF]=ds(imRep, min_area);

