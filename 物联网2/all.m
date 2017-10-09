%1.-----------二值化-----------------%
I=imread('lv0 - relax.bmp'); %读取初始图片
binaryzationGraph = ostu(I);
figure; imshow(binaryzationGraph); title('Ostu二值化后结果');
binaryzationGraph = (binaryzationGraph > 0) * 255;
%------------------------------------%

%%-----------------进行图像的旋转---------------------%
% ang = 180;
[x,y]=hough(I);

rotatedGraph = rotate(x,y,binaryzationGraph);
%rotatedGraph = bilinear_transformation(x,y,binaryzationGraph);
figure,imshow(rotatedGraph); title('旋转后的图像');
%rotatedGraph = rotate(x,y,binaryzationGraph);
%---------------------------------------------------%


%-----------形态学部分--------------%
rotate_image_ostu=ostu(rotatedGraph);
after_dilcor=morphology(rotatedGraph,rotate_image_ostu);
figure;
imshow(after_dilcor);
title('截取的结果');
%----------------------------------%


%------------------截取到条码部分了，接下来解码部分------------------------%
temp =  interpolation(after_dilcor);
temp =  interpolation(temp);
decode(temp);
%{
I=imread('test5.png'); %读取初始图片
binaryzationGraph = ostu(I);
%figure; imshow(binaryzationGraph); title('Ostu二值化后结果');
binaryzationGraph = (binaryzationGraph > 0) * 255;
%}
