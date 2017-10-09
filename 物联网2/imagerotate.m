function I=imagerotate(I1,angle,isSameSize) %必须是二值化之后的
%功能：实现图像的旋转变换
%angle---旋转角度
%isSameSize---取0 尺寸变大 取1 不变

[m,n]=size(I1);
rad=angle*pi/180;   %转化成弧度制
oldWidth=m;
oldHeight=n;


if(isSameSize==0)
    %计算原图像中的四个角的坐标（以图像中心为坐标系原点）
    oldX1=-(oldWidth-1)/2;
    oldY1=(oldHeight-1)/2;
    oldX2=(oldWidth-1)/2;
    oldY2=(oldHeight-1)/2;
    oldX3=-(oldWidth-1)/2;
    oldY3=-(oldHeight-1)/2;
    oldX4=(oldWidth-1)/2;
    oldY4=-(oldHeight-1)/2;

    %计算新图像的4个角的坐标（以图像中心为坐标系原点），自己在纸上画一下就能看懂这个几何关系啦，文字不好说明，反正就是点跟着原点转
    newX1=oldX1*cos(rad)+oldY1*sin(rad);
    newY1=-oldX1*sin(rad)+oldY1*cos(rad);
    newX2=oldX2*cos(rad)+oldY2*sin(rad);
    newY2=-oldX2*sin(rad)+oldY2*cos(rad);
    newX3=oldX3*cos(rad)+oldY3*sin(rad);
    newY3=-oldX3*sin(rad)+oldY3*cos(rad);
    newX4=oldX4*cos(rad)+oldY4*sin(rad);
    newY4=-oldX4*sin(rad)+oldY4*cos(rad);

    %计算旋转后的图像的宽度和高度
    newWidth=round(max(abs(newX1-newX4),abs(newX2-newX3))+0.5);
    newHeight=round(max(abs(newY1-newY4),abs(newY2-newY3))+0.5);

    %旋转前中心坐标
    a=round((oldWidth-1)/2+0.5);
    b=round((oldHeight-1)/2+0.5);

    %旋转后中心坐标
    c=round((newWidth-1)/2+0.5);
    d=round((newHeight-1)/2+0.5);
else
    a=round((oldWidth-1)/2+0.5);
    b=round((oldHeight-1)/2+0.5);
    c=a;
    d=b;
    newWidth=oldWidth;
    newHeight=oldHeight;
end

%---------?????????????
t1=[1 0 0;0 1 0;-a -b 1];
t2=[cos(rad) -sin(rad) 0;sin(rad) cos(rad) 0;0 0 1];
t3=[1 0 0;0 1 0;c d 1];
T=t1*t2*t3;

%构造新坐标系x和y的值
tx=ones(newWidth,newHeight)*255;
ty=ones(newWidth,newHeight)*255;
for i=1:newWidth
    for j=1:newHeight
        tx(i,j)=i;
        ty(i,j)=j;
    end
end

T

%-----------调用Matlab的maketform 和 tforminv 函数-------%
% tform=maketform('affine',T);
% [w z]=tforminv(tform,tx,ty); %反向坐标值,得到新坐标 一一对应 的旧坐标
%--------------------------------------------------------%
%-----------自己实现---------------------------------%
tform = inv(T)
for i=1:newWidth
    for j=1:newHeight
        s = [tx(i,j), ty(i,j) 1] * tform;
        w(i,j) = s(1);
        z(i,j) = s(2);
    end
end
%-----------自己实现---------------------------------%
I=double(zeros(newWidth,newHeight));

%给新图像各像素点赋值
for i=1:newWidth
    for j=1:newHeight
        S_x=w(i,j);
        S_y=z(i,j);
        if(S_x>=m-1||S_y>=n-1||double(uint16(S_x))<=0||double(uint16(S_y))<=0) 
            I(i,j)=255; %不在原图像上,变成白色
        else
            if (S_x/double(uint16(S_x))==1.0&S_y/double(uint16(S_y))==1.0)
                I(i,j)=I1(uint16(S_x),uint16(S_y));%整数点
            else
                I(i,j)=I1(uint16(S_x),uint16(S_y));%或许应该取周围的像素点的一个加权平均
            end
        end
    end
end

%给新图像各像素点赋值
%for i=1:newWidth
%    for j=1:newHeight
%        S_x=w(i,j);
%        S_y=z(i,j);
%        if(S_x>=m-1||S_y>=n-1||double(uint16(S_x))<=0||double(uint16(S_y))<=0) 
%            I(i,j)=255; %不在原图像上
%        else
%            if (S_x/double(uint16(S_x))==1.0&S_y/double(uint16(S_y))==1.0)
%                I(i,j)=I1(uint16(S_x),uint16(S_y));%整数点
%            else
%                %不是整数点
%                a=double(uint16(S_x));
%                b=double(uint16(S_y));
%                u=S_x-a;
%                v=S_y-b;
%                x11=double(I1(a,b));
%                x12=double(I1(a,b+1));
%                x21=double(I1(a+1,b));
%                x22=double(I1(a+1,b+1));
%                I(i,j)=uint8((1-u)*(1-v)*x11+(1-u)*v*x12+u*(1-v)*x21+u*v*x22);
%            end
%        end
%    end
%end
end
