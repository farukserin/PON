clc;
close all;
clear all;
imPathR=fullfile('..','..','Images','Dataset');
imPathW_segmented=fullfile('..','..','Images','Segmented_nuclei');
imPathW_splitted=fullfile('..','..','Images','Splitted_nuclei');

[imList1]=dir(imPathR);
[lgthImList1, imList1]=ruif(imList1);
kClusters=5;
radius=4;
divisionRate=1;
min_area=25;
max_area=120;
min_area_resized=round(min_area/divisionRate^2);
max_area_resized=round(max_area/divisionRate^2);
tic;
for d1=1:lgthImList1
    path1=fullfile(imPathR,imList1(d1).name);
    imList2=dir(path1);
    [lgthImList2, imList2]=ruif(imList2);
    for d2=1:lgthImList2
        path2=fullfile(path1,imList2(d2).name);
        imList3 = dir(path2);
        [lgthImList3, imList3]=ruif(imList3);
        imNo=0;
        for d3=1:lgthImList3
            path3=fullfile(path2,imList3(d3).name);
            img=imread(path3);
            length_h=size(img,1);
            length_v=size(img,2);
            length_h_resized=round(length_h/divisionRate);
            length_v_resized=round(length_v/divisionRate);
            
            [segmntdImgs]=kmeans_segmentation(img, kClusters);
            
            [binary_nuclei_k]=findClusterOfNuclei(img,segmntdImgs, kClusters);
            
            write_path_seg=fullfile(imPathW_segmented, ...
                imList1(d1).name,imList2(d2).name,imList3(d3).name);
            imwrite(binary_nuclei_k,write_path_seg,'jpg');
            
            imResNuc_k=imresize(logical(binary_nuclei_k),[length_h_resized,length_v_resized]);
            [imResMinRemoval]=ds(imResNuc_k, min_area_resized);
                                                 
            [imReMax]=ds(imResMinRemoval,max_area_resized);
            imApr=logical(imsubtract(imResMinRemoval,imReMax));        
            
            [imPar]=separateCellsCircular(imReMax,radius, ...
                      min_area_resized,max_area_resized);
                  
            imPar=logical(imadd(imApr,imPar)); 
            
            imRep=imresize(imPar, [length_h, length_v]);
           
            [imF]=ds(imRep, min_area);
            
            write_path_spl=fullfile(imPathW_splitted, ...
                imList1(d1).name,imList2(d2).name,imList3(d3).name);
            imwrite(imF,write_path_spl,'jpg');
            
            disp(strcat(num2str(d1),'-',num2str(d2),'-',num2str(d3)));
        end
    end
end

% tm_second=toc
% tm_minute=tm_second/60
% tm_hour=tm_minute/60
% tm_day=tm_hour/24
% 
% tm_day_for_600_images=round(tm_day*600)


disp('completed...')
