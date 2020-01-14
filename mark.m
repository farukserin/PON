% close all;
% clear all;
% clc;
% load('Results/img_1-1-1.mat')
% figure(1),imshow(imcomplement(imResMinRemoval));
% figure(2),imshow(imcomplement(imPar));
% figure(3),imshow(imcomplement(imF));

cC=bwconncomp(imF);
PList = regionprops(cC,'Centroid');
for i=1:cC.NumObjects    
    data(i,1)=round(PList(i).Centroid(2));
    data(i,2)=round(PList(i).Centroid(1));
end

image=img;
for i=1:size(data,1)
   image=change_image(image,[data(i,1),data(i,2)],[0 255 255],2,'combine');
end

imtool(image)
% imwrite(imF,'imF.jpg','jpg')
