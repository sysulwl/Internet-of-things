%假设我要旋转的图片是img，得到的四个顶点的坐标分别为
%任意选一个点，求与其他三个点的距离，找出中间距离的2个点，就是长
%2点之间求斜率
I1 = imread('lv2 - normal.jpg');

binaryzationGraph = ostu(I1);
figure;
imshow(binaryzationGraph);
title('Ostu二值化后结果');
%%-----------------------------------%


k = - 0.5 * pi;  %k是斜率，也就是倾斜角的tan值
%(y1 - y2) / (x1 - x2); %准备这样求斜率
ang = atan(k)*180/pi;
I=imagerotate(binaryzationGraph,ang,0);  %参数1是图片（必须二值化之后的），参数2是角度，参数3暂时未0，不用管
figure;
imshow(I);
title('旋转后结果');