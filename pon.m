function [imF]=pon(img,divisionRate,kClusters,min_area_resized,max_area_resized,radius, ...
        min_area)
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
end