function im_procssing=merge(im_procssing,im_procssed)
    cc_prsing = bwconncomp(im_procssing);
    PList_prsing = regionprops(cc_prsing,'PixelList');
    cc_prsed = bwconncomp(im_procssed);
    Cent_prsed = regionprops(cc_prsed,'Centroid');
    cends_of_comp=cell(cc_prsing.NumObjects,1);
    for i=1:cc_prsed.NumObjects
        for j=1:cc_prsing.NumObjects
            for k=1:length(PList_prsing(j).PixelList(:,1))
                if(round(Cent_prsed(i).Centroid(2))==PList_prsing(j).PixelList(k,2) ...
                          && (round(Cent_prsed(i).Centroid(1))==PList_prsing(j).PixelList(k,1) ...
                               || round(Cent_prsed(i).Centroid(1)+1)==PList_prsing(j).PixelList(k,1) ...
                                 || round(Cent_prsed(i).Centroid(1)-1)==PList_prsing(j).PixelList(k,1)))
                    cends_of_comp{j}=[cends_of_comp{j};[PList_prsing(j).PixelList(k,1),PList_prsing(j).PixelList(k,2)]];
                    break
                end
            end
        end
    end

    for i=1:cc_prsing.NumObjects
        for j=1:length(PList_prsing(i).PixelList(:,1))
            sz_c=size(cends_of_comp{i},1);
            for k=1:sz_c
                dist{i,j}(k)=sqrt((cends_of_comp{i}(k,1)-PList_prsing(i).PixelList(j,1))^2 ...
                      + (cends_of_comp{i}(k,2)-PList_prsing(i).PixelList(j,2))^2);
            end
            if(sz_c>0)
                [v1 ix]=min(dist{i,j});
                dist{i,j}(ix)=inf;
                [v2 ix]=min(dist{i,j});            
                if(abs(v1-v2)<2)
                        im_procssing(PList_prsing(i).PixelList(j,2), ...
                            PList_prsing(i).PixelList(j,1))=0;
                end
            end
        end
    end
end