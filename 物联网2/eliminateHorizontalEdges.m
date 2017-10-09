function [ ost ] = eliminateHorizontalEdges(ost,src )
[row,col] = size(ost);
dst = ost;
for i=1:row
    for j=2:col
        if src(i,j-1)==src(i,j)
            dst(i,j)=255;
        end
    end
end
ost = (dst==255);
%figure,imshow(ost);title('6.消除水平边缘后！');
end

