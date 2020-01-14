function [segmntdImgs]=kmeans_segmentation(img,nClrs)
    cform = makecform('srgb2lab');
    lab_he = applycform(img,cform);
    ab = double(lab_he(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    nColors = nClrs;
    cluster_idx= kmeans(ab,nColors,'distance','sqEuclidean'...
        ,'Replicates',3);
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    rgb_label = repmat(pixel_labels,[1 1 3]);
    for k = 1:nColors
        color = img;
        color(rgb_label ~= k) = 0;
        segmntdImgs{k} = color;
    end
end
