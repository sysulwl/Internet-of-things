function output = decode( ost )
%---------------1.�����ֵ�������ֵ----------%
%ost =  interpolation(ost);
I=imread(ost); %��ȡ��ʼͼƬ
binaryzationGraph = ostu(I);
%figure; imshow(binaryzationGraph); title('Ostu��ֵ������');
ost = (binaryzationGraph > 0) * 255;
%---------2.��������ͼ��--------------%
%{
[x1,x2,y1,y2] = cutCode(ost)
ost = ost(x1:x2,y1:y2);
[row,col]=size(ost);
figure,imshow(ost);
title('2.�����������ͼ��')
%}
%------------------3.��Ե���---------------------%
ost = edgeExtraction( ost );

%--------------4.������ֱ��Ե---------------------%
src = ost;
dst = eliminateVerticalEdges(ost);

%-----------------5.�ж�������������----------------%
[line,k] = findLines(dst); % k�õ�����line����ĳ��ȣ����ж��ٸ���ֵ��

%------------------6.����ˮƽ��Ե-------------------%
ost = eliminateHorizontalEdges(ost,src);

%---------------------7.��ȡ����-------------------%
acodes = extractCodeWord(line,k,ost);

%----------------8.ת����������Ϊ���������֣��������� �� �������֣�------%
dcodes = symbolToNumber(acodes);

%----------------------------9.����------------------------------------------%
output = codeToAnswer(dcodes);
end
