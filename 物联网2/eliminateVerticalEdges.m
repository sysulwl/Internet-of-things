function [ dst ] = eliminateVerticalEdges(ost)
%%消除垂直边缘
[row,col] = size(ost);
src = ost;
dst = ost;
for j=1:col
    for i=1:row-1
        if src(i+1,j)==src(i,j)
            dst(i,j)=255;
        end
    end
end
%figure,imshow(dst);title('4.消除垂直边缘后！dst')
end

