%快速积分图算法
%使用子函数fastintergral
clc;
clear;
close all;
[filename,filepath]=uigetfile({'*.jpg';'*.png';'*.bmp'},'Iput an Image');
str=[filepath filename];
Img=imread(str);
Img=rgb2gray(Img); 
[m n]=size(Img);
Img_intergral=uint64(zeros(m,n));
Img_intergral=fastIntergral(uint64(Img),Img_intergral,n,m);
