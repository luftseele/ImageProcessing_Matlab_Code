%利用k均值聚类算法进行图像分割k_means
%可以选择类别个数n
%初始聚类中心从对象集中随机选取
%迭代中止条件1.最大循环次数2.聚类中心收敛误差
%输入：簇的数目k和包含n个对象的数据库
%输出：k个簇，使平方误差准则最小
clc;
clear;
close all;
[filename,filepath]=uigetfile({'*.jpg';'*.png';'*.bmp'},'Iput an Image');
str=[filepath filename];
Img=imread(str);
Img=rgb2gray(Img);
[M N]=size(Img);
Img_o=zeros(M,N);

n=3;%簇的个数，即分为几类，至少为2
e=0.01;%迭代停止使用的误差容限
k=zeros(1,n);
k_bar=zeros(1,n);%存放簇平均值
k_pos=zeros(n,2);
for i=1:length(k)
    k_pos(i,1)=uint8(M*rand(1));
    k_pos(i,2)=uint8(N*rand(1));
    k(i)=Img(k_pos(i,1),k_pos(i,2));
end
d=zeros(1,length(k));%存放像素到聚类中心距离
k
%求初始误差准则函数E的值
%求欧式距离并分类
for i=1:M
    for j=1:N
        for dim=1:length(k)
            d(dim)=abs(double(Img(i,j))-double(k(dim)));
        end
        temp=min(d);
        Img_o(i,j)=find(d==temp,1,'first');
    end
end
for i=1:length(k)
    Img_o(k_pos(i))=i;
end
% figure,imshow(Img_o,[]);
%簇平均值
for i=1:length(k)
    temp=find(Img_o==i);
    k_bar(i)=sum(Img(temp))/numel(temp);
end
k_bar
%E
E=0;
for i=1:length(k)
    temp=find(Img_o==i);
    j=(double(Img(temp))/255-double(k_bar(i))/255).^2/numel(temp);
    E=E+sum(j);
end
E
%迭代直到最优
while E>e
    for i=1:M
        for j=1:N
            for dim=1:length(k)
                d(dim)=abs(double(Img(i,j))-double(k_bar(dim)));
            end
            temp=min(d);
            Img_o(i,j)=find(d==temp,1,'first');
        end
    end
    for i=1:length(k)
        temp=find(Img_o==i);
        k_bar(i)=sum(Img(temp))/numel(temp);
    end
    E=0;
    for i=1:length(k)
        temp=find(Img_o==i);
        j=(double(Img(temp))/255-double(k_bar(i))/255).^2/numel(temp);
        E=E+sum(j);
    end
    k_bar
    E
end

%显示结果
figure,imshow(Img_o,[]);



