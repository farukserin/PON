function image=change_image(image,px,color,range,recolor_or_combine)
sz=size(image);
y=px(1);
x=px(2);
if(y-range<=0)
    ys=1;
else
    ys=y-range;
end
if(y+range>sz(1))
    yf=sz(1);
else
    yf=y+range;
end
if(x-range<=0)
    xs=1;
else
    xs=x-range;
end
if(x+range>sz(2))
    xf=sz(2);
else
    xf=x+range;
end
if(strcmp(recolor_or_combine,'recolor'))
    image(ys:yf,xs:xf,1:3)=0;
    image(ys:yf,xs:xf,color)=255;
elseif(strcmp(recolor_or_combine,'combine'))
        image(ys:yf,xs:xf,1)=color(1);
        image(ys:yf,xs:xf,2)=color(2);
        image(ys:yf,xs:xf,3)=color(3);
end
end