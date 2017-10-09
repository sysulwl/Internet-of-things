%第五周内容：OSTU二值化，得到二值化后图像，作者：颜欣 %
function binaryzationGraph=ostu(G) %传入原RGB图片
clc;
%rgb图像转成灰度图
if length(size(G))>2
    G=rgb2gray(G);
end
%figure;imshow(G);title('灰度图');
%1.统计各灰度级像素在整幅图像中的个数
Count=imhist(G);%统计各灰度级像素在整幅图像中的个数

%2. 计算每个灰度级在图像中所占的比例
[row col]=size(G); %Row和Col是图像的长和宽

%        个数 => 比例 ： 计算每个灰度级在图像中所占的比例
Count=Count/(row*col);%计算每个灰度级在图像中所占的比例
%二值化
%3.去除两边不存在的灰度级
L=256;
syms firstDotNotZero;%第一个不为0的点
syms lastDotNotZero;%最后一个不为0的点
%记录直方图（ count） 第一个不为0的点
for i=1:L
    if Count(i)~=0 
        firstDotNotZero=i;
        break;
    end 
end
%记录直方图（ count） 最后一个不为0的点
for i=L:-1:1
    if Count(i)~=0 
        lastDotNotZero=i;
        break;
    end
end
Count1=zeros(0,lastDotNotZero+1);
x=zeros(0,lastDotNotZero+1);
%4.计算前t个像素的累加概率w0(t)和像素期望值u0(t)
%直方图横坐标
for i=1:lastDotNotZero+1
    x(i)=i;%直方图横坐标
end
%截取实现：count = count(firstDotNotZero:lastDotNotZero)
for i=firstDotNotZero:lastDotNotZero
    Count1(i)=Count(i);
end
sum0=0;
sum1=0;
%计算u0,w0
for t=1:lastDotNotZero
    %w0(t) = sum(count(1:t)) ------------%
    sum0=sum0+Count1(t);
    w0(t)=sum0;  
    %-------------------%
    %------------ % sum(x(1:t)*count(1:t)) / w0(t) % -----------%
    sum1=x(t)*Count1(t)+sum1;
    u0(t)=sum1/w0(t);  %sum(x(1:t)*count(1:t)) / w 0 (t)
end
%5.计算g（t）
%设前景像素所占比例为w0, 期望为u0, 背景像素所占比例为w1，期望为u1

%计算 整个图像的期望 u = w0 * u0 + w1 * u1;
%计算u
u=0;
for t=1:lastDotNotZero
    u=x(t)*Count1(t)+u;
end
max=0;
threshold=0;%阈值
for t=1:lastDotNotZero
    g(t)=w0(t)*(u-u0(t))^2/(1-w0(t));
    if g(t)>max
        max=g(t);
        threshold=t;%当t使得g(t)最大时，即为图像最佳阈值
    end
end
threshold=threshold/(256);
binaryzationGraph = im2bw(G,threshold); %二值化函数，设定阈值
