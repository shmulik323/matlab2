function [status,hsv,img_ans]=Identify(test_img)
Alist=dir('Apple\*.jpg');
Blist=dir('Banana\*.jpg');
Olist=dir('Orange\*.jpg');
Llist=dir('Lemon\*jpg');
Plist=dir('Pear\*.jpg');
for i=1:length(Alist)
    Apple{i}=imread(strcat('Apple\',Alist(i).name));
end
for i=1:length(Blist)
    Banana{i}=imread(strcat('Banana\',Blist(i).name));
end
for i=1:length(Olist)
    Orange{i}=imread(strcat('Orange\',Olist(i).name));
end
for i=1:length(Llist)
    Lemon{i}=imread(strcat('Lemon\',Llist(i).name));
end
for i=1:length(Plist)
    Pear{i}=imread(strcat('Pear\',Plist(i).name));
end
a=rgb2gray(imread('Orange\Orange.jpg'));
for i=1:length(4)
    Apple{i}=imresize(Apple{i},size(a));
    Banana{i}=imresize(Banana{i},size(a));
    Orange{i}=imresize(Orange{i},size(a));
    Lemon{i}=imresize(Lemon{i},size(a));
    Pear{i}=imresize(Pear{i},size(a));
end
%%
Adata={100,235,0,115,0,100};
Bdata={198,255,150,255,0,125};
Odata={220,255,82,203,0,50.0};
Ldata={222,255,178,255,0,50};
Pdata={100,242,150,245,0,170};
RGBdata={Adata,Bdata,Odata,Ldata,Pdata};

Amask=createMask(Apple{3},RGBdata{1});
Bmask=createMask(Banana{4},RGBdata{2});
Omask=createMask(Orange{4},RGBdata{3}); 
Lmask=createMask(Lemon{4},RGBdata{4}); 
Pmask=createMask(Pear{1},RGBdata{5}); 
Fmask={Amask,Bmask,Omask,Lmask,Pmask};
img=test_img;
img=imresize(img,size(a));
for i=1:length(RGBdata)
    image=createMask(img,RGBdata{i});
    img_size=imresize(Fmask{i},size(image));
    sub=imsubtract(image,img_size);
    img_pixel=sum(sub(:)==1);
    mask_pixel=sum(Fmask{i}(:)==1);
    res_pixel=img_pixel*1000/mask_pixel;
    if (res_pixel>= 0.1 && res_pixel<0.7) || (res_pixel>2 && res_pixel<=10)
        choice=i;
    end
end
    switch choice
        case 1
            img_ans=imread('apple1.jpg');
        case 2
           img_ans=imread('banana.jpg');
        case 3
           img_ans=imread('oranges.jpg');
        case 4
           img_ans=imread('lemons.jpg');
        case 5
            img_ans=imread('peers.jpg');
    end
   
 image=createMask(img,RGBdata{choice});
 img_size=imresize(Fmask{choice},size(image));
 a_edge=edge(image,'prewitt');
 b_gray=rgb2gray(img);
 hsv=b_gray;
 b_edge=edge(b_gray,'prewitt');
 a_comp=sum(a_edge(:)==1);
 b_comp=sum(b_edge(:)==1);
 res_perc=a_comp-b_comp;
 if res_perc>=1000
     status=imread('Rejected.jpg');
 else
     status=imread('Approved.jpg');
 end



