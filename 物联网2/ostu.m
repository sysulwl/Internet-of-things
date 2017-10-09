%���������ݣ�OSTU��ֵ�����õ���ֵ����ͼ�����ߣ����� %
function binaryzationGraph=ostu(G) %����ԭRGBͼƬ
clc;
%rgbͼ��ת�ɻҶ�ͼ
if length(size(G))>2
    G=rgb2gray(G);
end
%figure;imshow(G);title('�Ҷ�ͼ');
%1.ͳ�Ƹ��Ҷȼ�����������ͼ���еĸ���
Count=imhist(G);%ͳ�Ƹ��Ҷȼ�����������ͼ���еĸ���

%2. ����ÿ���Ҷȼ���ͼ������ռ�ı���
[row col]=size(G); %Row��Col��ͼ��ĳ��Ϳ�

%        ���� => ���� �� ����ÿ���Ҷȼ���ͼ������ռ�ı���
Count=Count/(row*col);%����ÿ���Ҷȼ���ͼ������ռ�ı���
%��ֵ��
%3.ȥ�����߲����ڵĻҶȼ�
L=256;
syms firstDotNotZero;%��һ����Ϊ0�ĵ�
syms lastDotNotZero;%���һ����Ϊ0�ĵ�
%��¼ֱ��ͼ�� count�� ��һ����Ϊ0�ĵ�
for i=1:L
    if Count(i)~=0 
        firstDotNotZero=i;
        break;
    end 
end
%��¼ֱ��ͼ�� count�� ���һ����Ϊ0�ĵ�
for i=L:-1:1
    if Count(i)~=0 
        lastDotNotZero=i;
        break;
    end
end
Count1=zeros(0,lastDotNotZero+1);
x=zeros(0,lastDotNotZero+1);
%4.����ǰt�����ص��ۼӸ���w0(t)����������ֵu0(t)
%ֱ��ͼ������
for i=1:lastDotNotZero+1
    x(i)=i;%ֱ��ͼ������
end
%��ȡʵ�֣�count = count(firstDotNotZero:lastDotNotZero)
for i=firstDotNotZero:lastDotNotZero
    Count1(i)=Count(i);
end
sum0=0;
sum1=0;
%����u0,w0
for t=1:lastDotNotZero
    %w0(t) = sum(count(1:t)) ------------%
    sum0=sum0+Count1(t);
    w0(t)=sum0;  
    %-------------------%
    %------------ % sum(x(1:t)*count(1:t)) / w0(t) % -----------%
    sum1=x(t)*Count1(t)+sum1;
    u0(t)=sum1/w0(t);  %sum(x(1:t)*count(1:t)) / w 0 (t)
end
%5.����g��t��
%��ǰ��������ռ����Ϊw0, ����Ϊu0, ����������ռ����Ϊw1������Ϊu1

%���� ����ͼ������� u = w0 * u0 + w1 * u1;
%����u
u=0;
for t=1:lastDotNotZero
    u=x(t)*Count1(t)+u;
end
max=0;
threshold=0;%��ֵ
for t=1:lastDotNotZero
    g(t)=w0(t)*(u-u0(t))^2/(1-w0(t));
    if g(t)>max
        max=g(t);
        threshold=t;%��tʹ��g(t)���ʱ����Ϊͼ�������ֵ
    end
end
threshold=threshold/(256);
binaryzationGraph = im2bw(G,threshold); %��ֵ���������趨��ֵ
