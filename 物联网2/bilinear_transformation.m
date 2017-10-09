function newimg = bilinear_transformation(x, y, img)
%读取图像
%figure; imshow(img);title('原图');
[row, col] = size(img);
%原图点
Pa = zeros(4, 3);
Pa(:, 2) = x; %横
Pa(:, 1) = y; %纵
Pa(:, 3) = sqrt(Pa(:, 1).^2 + Pa(:, 2).^2);
Pa = sortrows(Pa, 3);
Pa
%长宽
L12 = round(sqrt((Pa(1, 1) - Pa(2, 1))^2 + (Pa(1, 2) - Pa(2, 2))^2));
L13 = round(sqrt((Pa(1, 1) - Pa(3, 1))^2 + (Pa(1, 2) - Pa(3, 2))^2));
%目标图点
if L12 < L13
    if abs(Pa(1, 1) - Pa(2, 1)) > abs(Pa(1, 2) - Pa(2, 2)) %p2在p1下方
        Pb = [50 50; 50 + L12 50; 50 50 + L13; 50 + L12 50 + L13];
    else  %p2在p1右方
        Pb = [50 + L12 50; 50 50; 50 + L12 50 + L13; 50 50 + L13];
    end
else 
    if abs(Pa(1, 1) - Pa(2, 1)) > abs(Pa(1, 2) - Pa(2, 2))
        Pb = [50 50 + L13; 50 50;50 + L12 50 + L13;50 + L12 50];
    else 
        Pb = [50 50; 50 50 + L13; 50 + L12 50; 50 + L12 50 + L13];
    end
end

%求变换矩阵
output_value = [Pb(1, 1) Pb(2, 1) Pb(3, 1) Pb(4, 1); ...
    Pb(1, 2) Pb(2, 2) Pb(3, 2) Pb(4, 2); ...
    Pb(1,1) * Pb(1,2) Pb(2,1) * Pb(2,2) Pb(3,1) * Pb(3,2) Pb(4,1) * Pb(4,2);...
    1 1 1 1];
input_value = [Pa(1, 1) Pa(2, 1) Pa(3, 1) Pa(4, 1); Pa(1, 2) Pa(2, 2) Pa(3, 2) Pa(4, 2);];
transformation_matrix = input_value * inv(output_value);
%变换
newrow = 100 + L12;
newcol = 100 + L13;
newimg = ones(newrow, newcol);
for i = 1 : newrow
    for j = 1 : newcol
        t = round(transformation_matrix * [i; j; i * j; 1]);
        if t(1) > 0 && t(1) <= row && t(2) > 0 && t(2) <= col
            newimg(i, j) = img(t(1), t(2));
        end
    end
end
%{
for i = 1 : newrow
    for j = 1 : newcol
        if newimg(i, j) == 1
            newimg(i, j) = 0;
        end
        if newimg(i, j) == 0
            newimg(i, j) = 1;
        end
    end
end
%}
%newimg(Pa(1, 1), Pa(1, 2))
%newimg(Pa(1, 2), Pa(1, 1))

