%灰度亮的隶属度函数
%输入灰度值
%输出隶属度
function v=Mbright(z)
a=200;%a以上皆为亮，b为亮到灰的边界
b=50;
if z<=a && z>=a-b
    v=1-(a-z)/b;
elseif z>a
    v=1;
else
    v=0;
end
end