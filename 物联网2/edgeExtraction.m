function [ ost ] = edgeExtraction( ost )
[row,col] = size(ost);
src = ost;
%��Ե�������
topso=[1 1 1;0 0 0;-1 -1 -1];
% botso=[-1 -1 -1;0 0 0;1 1 1];
lefso=[1 0 -1;1 0 -1;1 0 -1];
% rigso=[-1 0 1;-1 0 1;-1 0 1];
for i=2:row-1
    for j=2:col-1
        %ȡ���Ըĵ�Ϊ���ģ�������ͬ����С������temp
        temp=src(i-1:i+1,j-1:j+1);
        %��ֱ������topso��temp����ٽ�ÿ������ÿ��ֵ����������Ϊtbs
        tbs =abs(sum(sum(topso.*temp)));
        %ˮƽ������lefso��temp����ٽ�ÿ������ÿ��ֵ����������Ϊlbs
        lbs =abs(sum(sum(lefso.*temp)));
        if (tbs==0) && (lbs==0)  %˼�������������ʲô��˼������������������������������������������������������������������
            ost(i,j)=255;
        end
    end
end
%figure,imshow(ost);title('3.��Ե���֮��');
end

