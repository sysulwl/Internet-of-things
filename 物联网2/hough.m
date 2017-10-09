function [ x,y ] = hough(textimage)
%textimage=imread('lv2 - normal.jpg');
%step1��ֵ��
%testostu=ostu(textimage);%����Ҳ�����õ�һ���ֵĴ�����ж�ֵ��
testostu=im2bw(textimage);%�Ҷ�ת��Ϊ��ֵ��ͼ��
[row,column]=size(testostu);
edgeimage =1-testostu;
%�Ƚ�С�Ľṹ����п�����
cons=ones(3,3);
X=2;Y=2;%ԭ��
after_dilcor=edgeimage;
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);%��ʴ
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,1);%����
%figure;imshow(after_dilcor);
%title('������֮���ͼ��');
%���ñȽϴ�Ľṹ��Ԫ�ر����㣬��Ŀ�������
cons=ones(25,25);
X=13;Y=13;%ԭ��
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,1);%����
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);%��ʴ
%figure;imshow(after_dilcor);
%title('������֮���ͼ��');
%Ѱ�ұ߽� ���ͺ��ȥԭʼͼ��------>> �õ�ȫ�ڣ�ֻ�а�ɫ��Ե��ͼ
cons = ones(5,5);
X = 3;Y = 3;
edgeimage = after_dilcor;
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,1);%����
edgeimage = after_dilcor - edgeimage;%�����ͺ�ļ�ȥԭͼ���õ��߽�

%�ۼ���---------�������µ�hough�任
rhomax = round(sqrt(row^2+column^2)); %���rho�����ֵ�Խ��߳���
H = zeros(2 * rhomax,180); %��������rhomax�������ۼ����Ĵ�С
%��������ǰrhomax
for x = 1:row
    for y = 1:column
        if edgeimage(x,y) == 1
            for theta =1:180 %�����Ƕ�
                rho = round(x*cos(theta/180*pi) + y*sin(theta/180*pi));
                if rho < 0
                    H(abs(rho)+1,theta) = H(abs(rho)+1,theta) + 1;
                else H(rho+rhomax,theta) = H(rho+rhomax,theta)+1; 
                end
            end
        end
    end
end
a = zeros(4,2);%a���������ĸ���ֵ������
[a(1,1),a(1,2)]= find(H==max(max(H)));
for i = a(1,1)-20:a(1,1)+20
    for j = a(1,2)-20:a(1,2)+20
        if i <=2*rhomax && i > 0 && j <=180 && j > 0
            H(i,j) = 0;
        end
    end
end
[a(3,1),a(3,2)]= find(H==max(max(H)));
for i = a(3,1)-20:a(3,1)+20
    for j = a(3,2)-20:a(3,2)+20
        if i <=2*rhomax && i > 0 && j <=180 && j > 0
            H(i,j) = 0;
        end
    end
end
[a(2,1),a(2,2)] = find(H==max(max(H)));
for i = a(2,1)-20:a(2,1)+20
    for j = a(2,2)-20:a(2,2)+20
        if i <=2*rhomax && i > 0 && j <=180 && j > 0
            H(i,j) = 0;
        end
    end
end
[a(4,1),a(4,2)]= find(H==max(max(H)));
for i = a(4,1)-20:a(4,1)+20
    for j = a(4,2)-20:a(4,2)+20
        if i <=2*rhomax && i > 0 && j <=180 && j > 0
            H(i,j) = 0;
        end
    end
end
k = zeros(1,4);
for i = 1:4
    k(i)=-cot(a(i,2)/180*pi);
end
b = zeros(1,4);
for i = 1:4
    if a(i,1) > rhomax 
    b(i) = (a(i,1)-rhomax)/sin(a(i,2)/180*pi);
    disp(b(i));
    else b(i) = (-a(i,1)+1)/sin(a(i,2)/180*pi);
    end
end
x= zeros(1,4); 
y= zeros(1,4);%���xy
for i=1:3
    y(i) = (b(i+1)-b(i))/(k(i)-k(i+1));
    x(i) = k(i)*y(i)+b(i);
end
    y(4) = (b(1)-b(4))/(k(4)-k(1));
    x(4) = k(4)*y(4)+b(4);
    figure;imshow(edgeimage);hold on%�����߽�ͼ�Լ��ĸ�����
    plot(x(1),y(1),'Marker','o','Color','red');hold on
    plot(x(2),y(2),'Marker','o','Color','red');hold on
    plot(x(3),y(3),'Marker','o','Color','red');hold on
    plot(x(4),y(4),'Marker','o','Color','red');
    title('�ҳ��ĸ����������ˣ�')
end

