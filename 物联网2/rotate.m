function [ rotatedGraph ] = rotate(x,y,I)
% 得到x数组坐标为：x1,x2,x3,x3,得到y数组坐标为y1,y2,y3,y4，并传入需要旋转的二值化之后的图片
% 输出就是旋转之后的图片
% 第一个点是参考点
% 定义2个变量存储另外一个点的坐标  
% 计算三个距离 
s2 = ( x(1) - x(2) )^2 + ( y(1) - y(2) )^2  ;
s3 = ( x(1) - x(3) )^2 + ( y(1) - y(3) )^2  ;
s4 = ( x(1) - x(3) )^2 + ( y(1) - y(3) )^2  ;
if(s2 < s3 && s3 < s4)
     ix = x(3); iy = y(3);
 elseif (s3 < s2 && s2 < s4)
     ix = x(2); iy = y(2);
else 
     ix = x(4); iy = y(4);
end
k = (y(1) - iy) / (x(1) - ix);  %k是斜率，也就是倾斜角的tan值
ang = -atan(k)*180/pi;
rotatedGraph = imagerotate(I,ang,0);  %参数1是图片（必须二值化之后的），参数2是角度，参数3暂时为0，不用管
end


