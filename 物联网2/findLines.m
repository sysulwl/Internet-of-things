function [ line,k] = findLines( dst )
%display('5.�鿴ÿ�з�ֵ')
[row,col]=size(dst);
obs = (dst==0);
rows= sum(obs,2);
%figure,plot(rows);title('5.�鿴ÿ�з�ֵ');
rowtvalue=round(col/20);
%��ֵ���ڵ�λ�ã��������浽һ������line[]��
line=zeros(1,row);
k=0;
for i=4:row-3
    if (rows(i)>rows(i-1)) && (rows(i)>rows(i-2)) && (rows(i)>rows(i-3)) && (rows(i)>rows(i+1)) && (rows(i)>rows(i+2)) && (rows(i)>rows(i+3)) && (rows(i)>rowtvalue)
        k=k+1;
        line(k)=i;
    end
end
%k
%display('��k+1���ַ���')
line=line(1:k);
end

