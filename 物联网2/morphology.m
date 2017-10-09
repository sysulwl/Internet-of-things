function result=morphology(textimage,testostu)
%textimage=imread('week6test2.png');
%step1二值化
%testostu=ostu(textimage);%这里也可以用第一部分的代码进行二值化
%testostu=im2bw(textimage);
[row,column]=size(testostu);

%step2定义结构体元素cons[1 1 1;1 1 1;1 1 1]
cons=ones(3,3);
X=2;Y=2;%原点

%step3边界扩展
test=zeros(row+2,column+2);
for i=1:row
    for j=1:column
        test(i+1,j+1)=testostu(i,j);
    end
end

%step4提取边缘
edgeimage=edge(test,'sobel');

%step5腐蚀膨胀
%lv0 1:8;lv2:3
after_dilcor=edgeimage;

for k=1:8
    after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,1);%膨胀
end
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);%腐蚀
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);
figure;imshow(after_dilcor);title('膨胀腐蚀后结果')
after_dilcor=after_dilcor(2:row+1,2:column+1);%去除边界上扩展的像素值

%step6重构去除与边界相连的连通域
h_k=after_dilcor;
for m=2:row-1    %取边界区域，内部赋值0
    for n=2:column-1
        h_k(m,n)=0;
    end
end
h_kplus1=dilateandcorrode(h_k,cons,X,Y,1)&after_dilcor;
while ~isequal(h_k, h_kplus1)         %重构
    h_k=h_kplus1;
    h_kplus1=dilateandcorrode(h_k,cons,X,Y,1)&after_dilcor;
end
after_dilcor=after_dilcor-h_k;%用原图像减去重构的结果
figure;imshow(after_dilcor);title('重构去除连通域');

%step7建立查找表，去除小面积连通域
[L,num]=bwlabel(after_dilcor);%取默认值8连通域
s=zeros(num,1);%存储连通域点数
max=0;%存储面积最大值
for i=1:num
    for m=1:row
        for n=1:column
            if L(m,n)==i 
                s(i)=s(i)+1;%统计每个连通域的面积
            end
            if s(i)>max 
                max=s(i);%记录最大连通域的面积
            end
        end
    end          
end
%把最大连通域面积的一半作为阈值，去除小于阈值的连通域。 
for m=1:row
    for n=1:column
        i=L(m,n);
        if(i~=0)
            if s(i)<0.5*max
                L(m,n)=0;
            end
        end
    end
end
figure;imshow(L);title('去除小面积连通域');

%step8投影定位、截取图像
Sy=zeros(row,1);
Sx=zeros(column,1);
for m=1:row           
    for n=1:column
        if L(m,n)~=0
            Sy(m)=Sy(m)+1;
            Sx(n)=Sx(n)+1;
        end
    end
end
%进行平滑
for i=1:row-1
    Sy(i)=0.7*Sy(i)+0.3*Sy(i+1);
end
for i=1:column-1             
    Sx(i)=0.7*Sx(i)+0.3*Sx(i+1);
end
%把各方向上的投影值的平均值作为阈值
avgcolumn=sum(Sx)/column;
avgrow=sum(Sy)/row;
beginX=0;endX=0;%定位的横坐标
for i=1:column-1
    if Sx(i)>avgcolumn&&beginX==0
        beginX=i;break;
    end
end
for i=column-1:-1:1
    if Sx(i)>avgcolumn&&endX==0
        endX=i;break;
    end
end
beginY=0;endY=0;%定位的纵坐标
for i=1:row-1
    if Sy(i)>avgrow&&beginY==0
        beginY=i;break;
    end
end
for i=row-1:-1:1
    if Sy(i)>avgrow&&endY==0
        endY=i;break;
    end
end
after_dilcor=textimage(beginY:endY,beginX:endX);            
%figure;imshow(after_dilcor);title('投影定位后截取的图像');
result=after_dilcor;