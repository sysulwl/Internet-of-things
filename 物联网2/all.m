%1.-----------��ֵ��-----------------%
I=imread('lv0 - relax.bmp'); %��ȡ��ʼͼƬ
binaryzationGraph = ostu(I);
figure; imshow(binaryzationGraph); title('Ostu��ֵ������');
binaryzationGraph = (binaryzationGraph > 0) * 255;
%------------------------------------%

%%-----------------����ͼ�����ת---------------------%
% ang = 180;
[x,y]=hough(I);

rotatedGraph = rotate(x,y,binaryzationGraph);
%rotatedGraph = bilinear_transformation(x,y,binaryzationGraph);
figure,imshow(rotatedGraph); title('��ת���ͼ��');
%rotatedGraph = rotate(x,y,binaryzationGraph);
%---------------------------------------------------%


%-----------��̬ѧ����--------------%
rotate_image_ostu=ostu(rotatedGraph);
after_dilcor=morphology(rotatedGraph,rotate_image_ostu);
figure;
imshow(after_dilcor);
title('��ȡ�Ľ��');
%----------------------------------%


%------------------��ȡ�����벿���ˣ����������벿��------------------------%
temp =  interpolation(after_dilcor);
temp =  interpolation(temp);
decode(temp);
%{
I=imread('test5.png'); %��ȡ��ʼͼƬ
binaryzationGraph = ostu(I);
%figure; imshow(binaryzationGraph); title('Ostu��ֵ������');
binaryzationGraph = (binaryzationGraph > 0) * 255;
%}
