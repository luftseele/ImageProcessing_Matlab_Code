%使用模糊集合进行灰度变换
%定义规则为暗的更暗，灰的不变，亮的更亮
%输入灰度z0
%利用对暗、灰、亮灰度的隶属度决定最终输出的灰度v0
%v0=(Mdark(z0)*Vd+Mgray(z0)*Vg+Mbright(z0)*Vb)/(Mdark(z0)+Mgray(z0)+Mbright(z0))
clc;
clear;
close all;
[filename,filepath]=uigetfile({'*.jpg';'*.png';'*.bmp'},'Iput an Image');
str=[filepath filename];
Img=imread(str);
Img=rgb2gray(Img);
Img=double(Img);
Vd=0;Vg=127;Vb=255;
[m n]=size(Img);
Img_fgt=zeros(m,n);
for i=1:m
    for j=1:n
        g=Img(i,j);
        a=Mdark(g);%Mdark,Mgray,Mbright的边界，即模糊程度将控制最终的结果
        b=Mgray(g);
        c=Mbright(g);
        Img_fgt(i,j)=(a*Vd+b*Vg+c*Vb)/(a+b+c);
    end
end
figure,imshow(Img,[]);title('original image');
figure,imshow(Img_fgt,[]);title('image after fuzzy gray transformation');