%灰度暗的隶属度函数
%输入灰度值
%输出隶属度
function v=Mdark(z)
a=50;%b以下皆为暗，a为灰到暗的边界
b=50;
if z<=a+b && z>=b
    v=1-(z-b)/a;
elseif z<b
    v=1;
else
    v=0;
end
end