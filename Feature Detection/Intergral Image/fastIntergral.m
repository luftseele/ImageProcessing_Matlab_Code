%快速求取积分图
%(i,j-1)的积分图+第j列的和
%详细原理及用途见论文
function output_Img=fastIntergral(input_Img,output_Img,W,H)
% calculate integral of the first line
columnSum=input_Img(1,:);%第j列的i行坐标和
output_Img(1,:)=input_Img(1,:);
for i=2:W
    output_Img(1,i) = output_Img(1,i)+output_Img(1,i-1);
end
for i=2:H
    %first column of each line
    columnSum(1)=columnSum(1)+input_Img(i,1);
    output_Img(i,1)=columnSum(1);
    %other columns
    for j=2:W
        columnSum(j)=columnSum(j)+input_Img(i,j);
        output_Img(i,j)=columnSum(j)+output_Img(i,j-1);
    end
end
end