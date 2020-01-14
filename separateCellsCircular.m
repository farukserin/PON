function [imPart]=separateCellsCircular(imI,radius,min_area, max_area)
    
    imPart=false(size(imI,1),size(imI,2));
    cont=1;
    
    while(cont==1)
        cc = bwconncomp(imI);
        EDiameter = regionprops(cc,'EquivDiameter');
        PList = regionprops(cc,'PixelList');
        Ara = regionprops(cc,'Area');
        cont=0;
        imI2=false(size(imI,1),size(imI,2));
        for i1=1:cc.NumObjects
            %             tic;
            cont=1;
            pCells=[];
            if(radius~=0)
                radius=radius;
            else
                radius=EDiameter(i1).EquivDiameter/2;
            end
            rds=radius;
            for j=1:length(PList(i1).PixelList(:,1))
                np=zeros(1,4);
                for i2=0:1:radius %inc-dec-x
                    for i3=0:1:radius%inc-dec-y
                        if((sqrt(rds^2+i3^2)-radius)>(sqrt(2)/2));
                            rds=rds-(sqrt(rds^2+i3^2)-radius);
                        end
                        for i4=0:rds
                            if((PList(i1).PixelList(j,2)+i3)<size(imI,1) ...
                                    && (PList(i1).PixelList(j,1)+i4)<size(imI,2) )
                                if(imI(PList(i1).PixelList(j,2)+i3,PList(i1).PixelList(j,1)+i4)==1)
                                    np(1)=np(1)+1;
                                end
                            end
                            
                            if((PList(i1).PixelList(j,2)-i3)>0 ...
                                    && (PList(i1).PixelList(j,1)+i4)<size(imI,2) ...
                                    && imI(PList(i1).PixelList(j,2)-i3,PList(i1).PixelList(j,1)+i4)==1)
                                
                                np(2)=np(2)+1;
                            end
                            
                            if((PList(i1).PixelList(j,2)+i3)<size(imI,1) ...
                                    && (PList(i1).PixelList(j,1)-i4)>0 ...
                                    && imI(PList(i1).PixelList(j,2)+i3,PList(i1).PixelList(j,1)-i4)==1)
                                np(3)=np(3)+1;
                            end
                            
                            if((PList(i1).PixelList(j,2)-i3)>0 ...
                                    && (PList(i1).PixelList(j,1)-i4)>0 ...
                                    && imI(PList(i1).PixelList(j,2)-i3,PList(i1).PixelList(j,1)-i4)==1)
                                np(4)=np(4)+1;
                            end
                        end
                    end
                end
                pCells(j)=sum(np)/Ara(i1).Area;
            end
            [nMxp iMxp]=max(pCells);
            ref=iMxp;
            for j=1:length(PList(i1).PixelList(:,1))
                dstn2=round(sqrt((PList(i1).PixelList(ref,1)-PList(i1).PixelList(j,1))^2 ...
                    +(PList(i1).PixelList(ref,2)-PList(i1).PixelList(j,2))^2));
                rds2=radius;%round(EDiameter(i1).EquivDiameter/2);
                if(dstn2==rds2-1 || dstn2==rds2)% || dstn2==rds2+1)
                    imI(PList(i1).PixelList(j,2),PList(i1).PixelList(j,1))=0;
                elseif(dstn2>rds2)
                    imI2(PList(i1).PixelList(j,2),PList(i1).PixelList(j,1))...
                        =imI(PList(i1).PixelList(j,2),PList(i1).PixelList(j,1));
                    imI(PList(i1).PixelList(j,2),PList(i1).PixelList(j,1),:)=0;
                end
            end
        end
        if(cont==1)
           % imI=bwareaopen(imI,min_area);
            imPart=logical(imadd(imPart,imI));

            [imMinRemoval]=bwareaopen(imI2, min_area);
            [imMax]=bwareaopen(imMinRemoval,max_area);
            imApr=logical(imsubtract(imMinRemoval,imMax));
            imPart=logical(imadd(imPart,imApr));
            imI=imMax;  
        end
    end
end

