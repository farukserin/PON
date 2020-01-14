function [im]=separateCellsLeftToRight(im,treshold)
    for i=1:size(im,1)
        start=1;
        counter=0;
        for j=1:size(im,2)
            if(im(i,j)==1)
                counter=counter+1;
            else
                if(counter<treshold)
                    for k=start:j
                        im(i,k)=0;
                    end
                end
                counter=0;
                start=j;
            end
        end
    end
end
