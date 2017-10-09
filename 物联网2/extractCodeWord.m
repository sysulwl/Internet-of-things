function [ acodes ] = extractCodeWord(line,k,ost) %消除水平边缘后的图
%display('7.提取码字')
[row,col] = size(ost);
%根据line数组，计算每一层的中心所在的行数到数组Layers[]上
Layers=zeros(1,k+1);
Layers(1)=round(line(1)/2);
for i=1:k-1
    Layers(i+1)=round((line(i)+line(i+1))/2);
end
Layers(k+1)=round((line(k)+row)/2);

minst=zeros(1,k+1);
codes=zeros(k+1,col); %记录此黑色像素和上一个记录黑色像素点的距离
for i=1:k+1
    m=0;
    for j=2:col
        if ost(Layers(i),j)==0  % 黑色，遍历到垂直的边缘
            %----记录此像素和上一个记录点的距离-----%
            if m==0             
                m=m+1;
                codes(i,m)=j;
                temp=j;
            else
                m=m+1;
                codes(i,m)=j-temp;
                temp=j;
            end
            %----记录此像素和上一个记录点的距离-----%
            minst(i)=m;  % 在minst中记录该行的点数
        end
    end
end

%----------------------计算模块的大小-----------------------------------------------------------------------%
%-------计算矩阵code中第一列的平均值，除以8，四舍五入后即为一个模块的长度aunit----------------%
asum=0;
for i=1:k+1
    asum=asum+codes(i,1);
end
aunit = round(asum/(k+1)/8);
%------------------------------------------------------------------------------------------%
%-------------code数组点除以aunit，四舍五入后就能等得到期望的符号码字------------------------%
acodes= zeros(k+1,minst(1));
for i=1:k+1
    for j=1:minst(1)
        acodes(i,j)=round(codes(i,j)/aunit);
    end
end
%------------------------------------------------------------------------------------------%        
[r,s]=size(acodes);
%r
%s
%acodes
end

