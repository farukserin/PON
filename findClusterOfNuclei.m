function [binary_nuclei]=findClusterOfNuclei(img,segmntdImgs,nK)
    grayImg=rgb2gray(img);
    grayImg = reshape(grayImg,size(img,1)*size(img,2),1);
    grayImgClrs=zeros(nK,1);
    for i=1:nK
        ima1=segmntdImgs{i};
        level = graythresh(ima1);
        imA{i}=im2bw(ima1,level);
        CC(i) = bwconncomp(imA{i});
        pxlIdxLst=[];
        for pix=1:length(CC(i).PixelIdxList)
            pxlIdxLst=vertcat(pxlIdxLst,CC(i).PixelIdxList{1,pix});
        end
        grayImgClrs(i)=0;
        lgth3=length(pxlIdxLst);
        for md=1:lgth3
            grayImgClrs(i)=grayImgClrs(i)+...
                double(grayImg(pxlIdxLst(md)));
        end
        grayImgClrs(i)=grayImgClrs(i)/length(pxlIdxLst);
    end
    [mnmC indx]=min(grayImgClrs);
       
    
    binary_nuclei=zeros(size(img,1),size(img,2));
    for i=1:size(img,1)
        for j=1:size(img,2)
            if(sum(segmntdImgs{indx}(i,j,:))~=0)
                binary_nuclei(i,j)=1;
            end
        end
    end
    binary_nuclei=imfill(binary_nuclei,'holes');
end
