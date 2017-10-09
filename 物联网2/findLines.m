function [ line,k] = findLines( dst )
%display('5.查看每行峰值')
[row,col]=size(dst);
obs = (dst==0);
rows= sum(obs,2);
%figure,plot(rows);title('5.查看每行峰值');
rowtvalue=round(col/20);
%峰值所在的位置（行数）存到一个数组line[]上
line=zeros(1,row);
k=0;
for i=4:row-3
    if (rows(i)>rows(i-1)) && (rows(i)>rows(i-2)) && (rows(i)>rows(i-3)) && (rows(i)>rows(i+1)) && (rows(i)>rows(i+2)) && (rows(i)>rows(i+3)) && (rows(i)>rowtvalue)
        k=k+1;
        line(k)=i;
    end
end
%k
%display('有k+1个字符！')
line=line(1:k);
end

