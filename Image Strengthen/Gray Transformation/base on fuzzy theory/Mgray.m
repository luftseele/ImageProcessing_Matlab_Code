%灰度灰的隶属度函数
%输入灰度值
%输出隶属度
function v=Mgray(z)
a=127;%a为灰点，[a-b,a+b]为灰的隶属范围
b=50;
if z==a
    v=1;
elseif z>a && z<=a+b
    v=(a+b-z)/b;
elseif z>=a-b && z<a
    v=(z-a+b)/b;
else
    v=0;
end
end