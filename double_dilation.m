%4fig8

r=8;
c=10;
img=zeros(r,c);

img(3,3:8)=1;
img(3:6,3)=1;
img(7,4:7)=1;
img(3:6,8)=1;
img(4,7)=1;
img(3,7)=0;

se = strel('rectangle',[2 2]);
se2 = reflect(se);

imgB=imdilate(img,se);
imgB_=imdilate(imgB,se2);

imtool(imgB_)
