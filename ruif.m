function [lgthImLst, folder]=ruif(folder)%removeUnnessasaryInfoInFolder
    i=1;
    while(i<=length(folder))
        if((strcmp(folder(i).name,'.') || strcmp(folder(i).name,'..')) ...
                || strcmp(folder(i).name,'Thumbs.db') ...
                    || strcmp(folder(i).name(1),'.'))
            folder(i)=[];
            i=i-1;
        end
        i=i+1;
    end
    lgthImLst=length(folder);
end
