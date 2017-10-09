function [ ost ] = edgeExtraction( ost )
[row,col] = size(ost);
src = ost;
%边缘检测算子
topso=[1 1 1;0 0 0;-1 -1 -1];
% botso=[-1 -1 -1;0 0 0;1 1 1];
lefso=[1 0 -1;1 0 -1;1 0 -1];
% rigso=[-1 0 1;-1 0 1;-1 0 1];
for i=2:row-1
    for j=2:col-1
        %取出以改点为中心，与算子同样大小的区域temp
        temp=src(i-1:i+1,j-1:j+1);
        %垂直方向上topso与temp点乘再将每个矩阵每个值加起来，记为tbs
        tbs =abs(sum(sum(topso.*temp)));
        %水平方向上lefso与temp点乘再将每个矩阵每个值加起来，记为lbs
        lbs =abs(sum(sum(lefso.*temp)));
        if (tbs==0) && (lbs==0)  %思考：这种情况是什么意思？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
            ost(i,j)=255;
        end
    end
end
%figure,imshow(ost);title('3.边缘检测之后！');
end

