%非对称自适应中值滤波
%修改自冈萨雷斯的自适应中值滤波
function f = adpmedian(g, Smax)
%ADPMEDIAN Perform adaptive median filtering.
%   F = ADPMEDIAN(G, SMAX) performs adaptive median filtering of
%   image G.  The median filter starts at size 3-by-3 and iterates up
%   to size SMAX-by-SMAX. SMAX must be an odd integer greater than 1.

%   Copyright 2002-2004 R. C. Gonzalez, R. E. Woods, & S. L. Eddins
%   Digital Image Processing Using MATLAB, Prentice-Hall, 2004
%   $Revision: 1.5 $  $Date: 2003/11/21 14:19:05 $

% SMAX must be an odd, positive integer greater than 1.
if (Smax <= 1) | (Smax/2 == round(Smax/2)) | (Smax ~= round(Smax))
   error('SMAX must be an odd integer > 1.')
end
[M, N] = size(g);

% Initial setup.
f = g;
f(:) = 0;
alreadyProcessed = false(size(g));
% lg=g;%存放平均灰度
% lg(:)=0;

% Begin filtering.
for k = 3:2:Smax
   zmin = ordfilt2(g, 1, ones(k, k), 'symmetric');
   zmax = ordfilt2(g, k * k, ones(k, k), 'symmetric');
   zmed = medfilt2(g, [k k], 'symmetric');
%    h=ones(k,k)/(k*k);
%    lg=imfilter(g,h,'symmetric');%求局部平均平均
   
%processUsingLevelB = (zmed < lg) & (zmax > zmed) & ~alreadyProcessed，对局部最小使用最大窗口
%processUsingLevelB = (zmin < zmed) & (lg > zmed) & ~alreadyProcessed，对局部最大使用最大窗口
   processUsingLevelB = (zmed > zmin) & (zmax > zmed) & ~alreadyProcessed; %与局部平均相比，体现非对称
   zB = (g > zmin) & (zmax > g);%用原来的还是用中值滤波结果，g可以等于max
   outputZxy  = processUsingLevelB & zB;
   outputZmed = processUsingLevelB & ~zB;
   f(outputZxy) = g(outputZxy);
   f(outputZmed) = zmed(outputZmed);
   
   alreadyProcessed = alreadyProcessed | processUsingLevelB;
   if all(alreadyProcessed(:))
      break;
   end
end

% Output zmed for any remaining unprocessed pixels. Note that this
% zmed was computed using a window of size Smax-by-Smax, which is
% the final value of k in the loop.
f(~alreadyProcessed) = zmed(~alreadyProcessed);