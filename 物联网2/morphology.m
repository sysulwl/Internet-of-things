function result=morphology(textimage,testostu)
%textimage=imread('week6test2.png');
%step1��ֵ��
%testostu=ostu(textimage);%����Ҳ�����õ�һ���ֵĴ�����ж�ֵ��
%testostu=im2bw(textimage);
[row,column]=size(testostu);

%step2����ṹ��Ԫ��cons[1 1 1;1 1 1;1 1 1]
cons=ones(3,3);
X=2;Y=2;%ԭ��

%step3�߽���չ
test=zeros(row+2,column+2);
for i=1:row
    for j=1:column
        test(i+1,j+1)=testostu(i,j);
    end
end

%step4��ȡ��Ե
edgeimage=edge(test,'sobel');

%step5��ʴ����
%lv0 1:8;lv2:3
after_dilcor=edgeimage;

for k=1:8
    after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,1);%����
end
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);%��ʴ
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);
after_dilcor=dilateandcorrode(after_dilcor,cons,X,Y,0);
figure;imshow(after_dilcor);title('���͸�ʴ����')
after_dilcor=after_dilcor(2:row+1,2:column+1);%ȥ���߽�����չ������ֵ

%step6�ع�ȥ����߽���������ͨ��
h_k=after_dilcor;
for m=2:row-1    %ȡ�߽������ڲ���ֵ0
    for n=2:column-1
        h_k(m,n)=0;
    end
end
h_kplus1=dilateandcorrode(h_k,cons,X,Y,1)&after_dilcor;
while ~isequal(h_k, h_kplus1)         %�ع�
    h_k=h_kplus1;
    h_kplus1=dilateandcorrode(h_k,cons,X,Y,1)&after_dilcor;
end
after_dilcor=after_dilcor-h_k;%��ԭͼ���ȥ�ع��Ľ��
figure;imshow(after_dilcor);title('�ع�ȥ����ͨ��');

%step7�������ұ�ȥ��С�����ͨ��
[L,num]=bwlabel(after_dilcor);%ȡĬ��ֵ8��ͨ��
s=zeros(num,1);%�洢��ͨ�����
max=0;%�洢������ֵ
for i=1:num
    for m=1:row
        for n=1:column
            if L(m,n)==i 
                s(i)=s(i)+1;%ͳ��ÿ����ͨ������
            end
            if s(i)>max 
                max=s(i);%��¼�����ͨ������
            end
        end
    end          
end
%�������ͨ�������һ����Ϊ��ֵ��ȥ��С����ֵ����ͨ�� 
for m=1:row
    for n=1:column
        i=L(m,n);
        if(i~=0)
            if s(i)<0.5*max
                L(m,n)=0;
            end
        end
    end
end
figure;imshow(L);title('ȥ��С�����ͨ��');

%step8ͶӰ��λ����ȡͼ��
Sy=zeros(row,1);
Sx=zeros(column,1);
for m=1:row           
    for n=1:column
        if L(m,n)~=0
            Sy(m)=Sy(m)+1;
            Sx(n)=Sx(n)+1;
        end
    end
end
%����ƽ��
for i=1:row-1
    Sy(i)=0.7*Sy(i)+0.3*Sy(i+1);
end
for i=1:column-1             
    Sx(i)=0.7*Sx(i)+0.3*Sx(i+1);
end
%�Ѹ������ϵ�ͶӰֵ��ƽ��ֵ��Ϊ��ֵ
avgcolumn=sum(Sx)/column;
avgrow=sum(Sy)/row;
beginX=0;endX=0;%��λ�ĺ�����
for i=1:column-1
    if Sx(i)>avgcolumn&&beginX==0
        beginX=i;break;
    end
end
for i=column-1:-1:1
    if Sx(i)>avgcolumn&&endX==0
        endX=i;break;
    end
end
beginY=0;endY=0;%��λ��������
for i=1:row-1
    if Sy(i)>avgrow&&beginY==0
        beginY=i;break;
    end
end
for i=row-1:-1:1
    if Sy(i)>avgrow&&endY==0
        endY=i;break;
    end
end
after_dilcor=textimage(beginY:endY,beginX:endX);            
%figure;imshow(after_dilcor);title('ͶӰ��λ���ȡ��ͼ��');
result=after_dilcor;