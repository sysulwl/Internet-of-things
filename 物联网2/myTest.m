%������Ҫ��ת��ͼƬ��img���õ����ĸ����������ֱ�Ϊ
%����ѡһ���㣬��������������ľ��룬�ҳ��м�����2���㣬���ǳ�
%2��֮����б��
I1 = imread('lv2 - normal.jpg');

binaryzationGraph = ostu(I1);
figure;
imshow(binaryzationGraph);
title('Ostu��ֵ������');
%%-----------------------------------%


k = - 0.5 * pi;  %k��б�ʣ�Ҳ������б�ǵ�tanֵ
%(y1 - y2) / (x1 - x2); %׼��������б��
ang = atan(k)*180/pi;
I=imagerotate(binaryzationGraph,ang,0);  %����1��ͼƬ�������ֵ��֮��ģ�������2�ǽǶȣ�����3��ʱδ0�����ù�
figure;
imshow(I);
title('��ת����');