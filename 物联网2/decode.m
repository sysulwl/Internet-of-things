function output = decode( ost )
%---------------1.横向插值和纵向插值----------%
%ost =  interpolation(ost);
I=imread(ost); %读取初始图片
binaryzationGraph = ostu(I);
%figure; imshow(binaryzationGraph); title('Ostu二值化后结果');
ost = (binaryzationGraph > 0) * 255;
%---------2.分离条码图像--------------%
%{
[x1,x2,y1,y2] = cutCode(ost)
ost = ost(x1:x2,y1:y2);
[row,col]=size(ost);
figure,imshow(ost);
title('2.分离出的条码图像')
%}
%------------------3.边缘检测---------------------%
ost = edgeExtraction( ost );

%--------------4.消除垂直边缘---------------------%
src = ost;
dst = eliminateVerticalEdges(ost);

%-----------------5.判断数据码字行数----------------%
[line,k] = findLines(dst); % k得到的是line数组的长度，即有多少个峰值点

%------------------6.消除水平边缘-------------------%
ost = eliminateHorizontalEdges(ost,src);

%---------------------7.提取码字-------------------%
acodes = extractCodeWord(line,k,ost);

%----------------8.转换符号码字为待解码码字（符号码字 到 数字码字）------%
dcodes = symbolToNumber(acodes);

%----------------------------9.解码------------------------------------------%
output = codeToAnswer(dcodes);
end
