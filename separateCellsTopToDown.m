function [im]=separateCellsTopToDown(im,treshold)
    for i=1:size(im,2)
        start=1;
        counter=0;
        for j=1:size(im,1)
            if(im(j,i)==1)
                counter=counter+1;
            else
                if(counter<treshold)
                    for k=start:j
                        im(k,i)=0;
                    end
                end
                counter=0;
                start=j;
            end
        end
    end
end
