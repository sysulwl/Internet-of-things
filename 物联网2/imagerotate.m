function I=imagerotate(I1,angle,isSameSize) %�����Ƕ�ֵ��֮���
%���ܣ�ʵ��ͼ�����ת�任
%angle---��ת�Ƕ�
%isSameSize---ȡ0 �ߴ��� ȡ1 ����

[m,n]=size(I1);
rad=angle*pi/180;   %ת���ɻ�����
oldWidth=m;
oldHeight=n;


if(isSameSize==0)
    %����ԭͼ���е��ĸ��ǵ����꣨��ͼ������Ϊ����ϵԭ�㣩
    oldX1=-(oldWidth-1)/2;
    oldY1=(oldHeight-1)/2;
    oldX2=(oldWidth-1)/2;
    oldY2=(oldHeight-1)/2;
    oldX3=-(oldWidth-1)/2;
    oldY3=-(oldHeight-1)/2;
    oldX4=(oldWidth-1)/2;
    oldY4=-(oldHeight-1)/2;

    %������ͼ���4���ǵ����꣨��ͼ������Ϊ����ϵԭ�㣩���Լ���ֽ�ϻ�һ�¾��ܿ���������ι�ϵ�������ֲ���˵�����������ǵ����ԭ��ת
    newX1=oldX1*cos(rad)+oldY1*sin(rad);
    newY1=-oldX1*sin(rad)+oldY1*cos(rad);
    newX2=oldX2*cos(rad)+oldY2*sin(rad);
    newY2=-oldX2*sin(rad)+oldY2*cos(rad);
    newX3=oldX3*cos(rad)+oldY3*sin(rad);
    newY3=-oldX3*sin(rad)+oldY3*cos(rad);
    newX4=oldX4*cos(rad)+oldY4*sin(rad);
    newY4=-oldX4*sin(rad)+oldY4*cos(rad);

    %������ת���ͼ��Ŀ�Ⱥ͸߶�
    newWidth=round(max(abs(newX1-newX4),abs(newX2-newX3))+0.5);
    newHeight=round(max(abs(newY1-newY4),abs(newY2-newY3))+0.5);

    %��תǰ��������
    a=round((oldWidth-1)/2+0.5);
    b=round((oldHeight-1)/2+0.5);

    %��ת����������
    c=round((newWidth-1)/2+0.5);
    d=round((newHeight-1)/2+0.5);
else
    a=round((oldWidth-1)/2+0.5);
    b=round((oldHeight-1)/2+0.5);
    c=a;
    d=b;
    newWidth=oldWidth;
    newHeight=oldHeight;
end

%---------?????????????
t1=[1 0 0;0 1 0;-a -b 1];
t2=[cos(rad) -sin(rad) 0;sin(rad) cos(rad) 0;0 0 1];
t3=[1 0 0;0 1 0;c d 1];
T=t1*t2*t3;

%����������ϵx��y��ֵ
tx=ones(newWidth,newHeight)*255;
ty=ones(newWidth,newHeight)*255;
for i=1:newWidth
    for j=1:newHeight
        tx(i,j)=i;
        ty(i,j)=j;
    end
end

T

%-----------����Matlab��maketform �� tforminv ����-------%
% tform=maketform('affine',T);
% [w z]=tforminv(tform,tx,ty); %��������ֵ,�õ������� һһ��Ӧ �ľ�����
%--------------------------------------------------------%
%-----------�Լ�ʵ��---------------------------------%
tform = inv(T)
for i=1:newWidth
    for j=1:newHeight
        s = [tx(i,j), ty(i,j) 1] * tform;
        w(i,j) = s(1);
        z(i,j) = s(2);
    end
end
%-----------�Լ�ʵ��---------------------------------%
I=double(zeros(newWidth,newHeight));

%����ͼ������ص㸳ֵ
for i=1:newWidth
    for j=1:newHeight
        S_x=w(i,j);
        S_y=z(i,j);
        if(S_x>=m-1||S_y>=n-1||double(uint16(S_x))<=0||double(uint16(S_y))<=0) 
            I(i,j)=255; %����ԭͼ����,��ɰ�ɫ
        else
            if (S_x/double(uint16(S_x))==1.0&S_y/double(uint16(S_y))==1.0)
                I(i,j)=I1(uint16(S_x),uint16(S_y));%������
            else
                I(i,j)=I1(uint16(S_x),uint16(S_y));%����Ӧ��ȡ��Χ�����ص��һ����Ȩƽ��
            end
        end
    end
end

%����ͼ������ص㸳ֵ
%for i=1:newWidth
%    for j=1:newHeight
%        S_x=w(i,j);
%        S_y=z(i,j);
%        if(S_x>=m-1||S_y>=n-1||double(uint16(S_x))<=0||double(uint16(S_y))<=0) 
%            I(i,j)=255; %����ԭͼ����
%        else
%            if (S_x/double(uint16(S_x))==1.0&S_y/double(uint16(S_y))==1.0)
%                I(i,j)=I1(uint16(S_x),uint16(S_y));%������
%            else
%                %����������
%                a=double(uint16(S_x));
%                b=double(uint16(S_y));
%                u=S_x-a;
%                v=S_y-b;
%                x11=double(I1(a,b));
%                x12=double(I1(a,b+1));
%                x21=double(I1(a+1,b));
%                x22=double(I1(a+1,b+1));
%                I(i,j)=uint8((1-u)*(1-v)*x11+(1-u)*v*x12+u*(1-v)*x21+u*v*x22);
%            end
%        end
%    end
%end
end
