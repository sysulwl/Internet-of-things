function [ x,y ] = hough(textimage)
%textimage=imread('lv2 - normal.jpg');
%step1二值化
%testostu=ostu(textimage);%这里也可以用第一部分的代码进行二值化
testostu=im2bw(textimage);%灰度转化为二值化图像
[row,column]=size(testostu);
edgeimage =1-testostu;
%比较小的结构体进行开运算
cons=ones(3,3);
X=2;Y=2;%原点
after_dilcor=edgeimage;
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);%腐蚀
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,1);%膨胀
%figure;imshow(after_dilcor);
%title('开运算之后的图像');
%再用比较大的结构体元素闭运算，把目标揉成团
cons=ones(25,25);
X=13;Y=13;%原点
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,1);%膨胀
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);%腐蚀
%figure;imshow(after_dilcor);
%title('闭运算之后的图像');
%寻找边界 膨胀后减去原始图像------>> 得到全黑，只有白色边缘的图
cons = ones(5,5);
X = 3;Y = 3;
edgeimage = after_dilcor;
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,1);%膨胀
edgeimage = after_dilcor - edgeimage;%用膨胀后的减去原图，得到边界

%累加器---------极坐标下的hough变换
rhomax = round(sqrt(row^2+column^2)); %获得rho的最大值对角线长度
H = zeros(2 * rhomax,180); %用两倍的rhomax来定义累加器的大小
%负数存在前rhomax
for x = 1:row
    for y = 1:column
        if edgeimage(x,y) == 1
            for theta =1:180 %遍历角度
                rho = round(x*cos(theta/180*pi) + y*sin(theta/180*pi));
                if rho < 0
                    H(abs(rho)+1,theta) = H(abs(rho)+1,theta) + 1;
                else H(rho+rhomax,theta) = H(rho+rhomax,theta)+1; 
                end
            end
        end
    end
end
a = zeros(4,2);%a用来储存四个峰值的坐标
[a(1,1),a(1,2)]= find(H==max(max(H)));
for i = a(1,1)-20:a(1,1)+20
    for j = a(1,2)-20:a(1,2)+20
        if i <=2*rhomax && i > 0 && j <=180 && j > 0
            H(i,j) = 0;
        end
    end
end
[a(3,1),a(3,2)]= find(H==max(max(H)));
for i = a(3,1)-20:a(3,1)+20
    for j = a(3,2)-20:a(3,2)+20
        if i <=2*rhomax && i > 0 && j <=180 && j > 0
            H(i,j) = 0;
        end
    end
end
[a(2,1),a(2,2)] = find(H==max(max(H)));
for i = a(2,1)-20:a(2,1)+20
    for j = a(2,2)-20:a(2,2)+20
        if i <=2*rhomax && i > 0 && j <=180 && j > 0
            H(i,j) = 0;
        end
    end
end
[a(4,1),a(4,2)]= find(H==max(max(H)));
for i = a(4,1)-20:a(4,1)+20
    for j = a(4,2)-20:a(4,2)+20
        if i <=2*rhomax && i > 0 && j <=180 && j > 0
            H(i,j) = 0;
        end
    end
end
k = zeros(1,4);
for i = 1:4
    k(i)=-cot(a(i,2)/180*pi);
end
b = zeros(1,4);
for i = 1:4
    if a(i,1) > rhomax 
    b(i) = (a(i,1)-rhomax)/sin(a(i,2)/180*pi);
    disp(b(i));
    else b(i) = (-a(i,1)+1)/sin(a(i,2)/180*pi);
    end
end
x= zeros(1,4); 
y= zeros(1,4);%求出xy
for i=1:3
    y(i) = (b(i+1)-b(i))/(k(i)-k(i+1));
    x(i) = k(i)*y(i)+b(i);
end
    y(4) = (b(1)-b(4))/(k(4)-k(1));
    x(4) = k(4)*y(4)+b(4);
    figure;imshow(edgeimage);hold on%画出边界图以及四个顶点
    plot(x(1),y(1),'Marker','o','Color','red');hold on
    plot(x(2),y(2),'Marker','o','Color','red');hold on
    plot(x(3),y(3),'Marker','o','Color','red');hold on
    plot(x(4),y(4),'Marker','o','Color','red');
    title('找出四个顶点坐标了！')
end

