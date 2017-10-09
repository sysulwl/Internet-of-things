function ost = interpolation( temp )
ost=double(temp);
[new_row,new_col]=size(ost);

%-------------------------------插值---------------------------%
%旋转后横向邻近插值
for i=1:new_row
    for j=1:new_col-2
        if ((ost(i,j)==0)&&(ost(i,j+2)==0)&&(ost(i,j+1)==255))
            ost(i,j+1)=0;
        end
        if ((ost(i,j)==255)&&(ost(i,j+2)==255)&&(ost(i,j+1)==0))
            ost(i,j+1)=255;
        end
    end
end

%旋转后纵向邻近插值
for i=1:new_col
    for j=1:new_row-2
        if ((ost(j,i)==0)&&(ost(j+2,i)==0)&&(ost(j+1,i)==255))
            ost(j+1,i)=0;
        end
        if ((ost(j,i)==255)&&(ost(j+2,i)==255)&&(ost(j+1,i)==0))
            ost(j+1,i)=255;
        end
    end
end

%扫描一下看看有没有比较奇怪的孤立点
for i=1:new_col
    for j=3:new_row-3
        if ((ost(j-2,i)==0)&&(ost(j-1,i)==0)&&(ost(j,i)==255)&&(ost(j+1,i)==255)&&(ost(j+2,i)==0)&&(ost(j+3,i)==0))
            ost(j,i)=0;
            ost(j+1,i)=0;
        end
    end
end
figure,imshow(ost);
title('横向插值和纵向插值之后！');
%---------------------------插值--------------------------------%

end

