function [imI]=ds(imI,a)%deleteSmallest    
    cC = bwconncomp(imI);
    PList = regionprops(cC,'PixelList');
    Ara = regionprops(cC,'Area');
    for i=1:cC.NumObjects
        if (Ara(i).Area<a)
            for j=1:length(PList(i).PixelList(:,1))
                imI(PList(i).PixelList(j,2),PList(i).PixelList(j,1),:)=0;
            end
        end
    end 
end

