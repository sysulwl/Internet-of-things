function [ acodes ] = extractCodeWord(line,k,ost) %����ˮƽ��Ե���ͼ
%display('7.��ȡ����')
[row,col] = size(ost);
%����line���飬����ÿһ����������ڵ�����������Layers[]��
Layers=zeros(1,k+1);
Layers(1)=round(line(1)/2);
for i=1:k-1
    Layers(i+1)=round((line(i)+line(i+1))/2);
end
Layers(k+1)=round((line(k)+row)/2);

minst=zeros(1,k+1);
codes=zeros(k+1,col); %��¼�˺�ɫ���غ���һ����¼��ɫ���ص�ľ���
for i=1:k+1
    m=0;
    for j=2:col
        if ost(Layers(i),j)==0  % ��ɫ����������ֱ�ı�Ե
            %----��¼�����غ���һ����¼��ľ���-----%
            if m==0             
                m=m+1;
                codes(i,m)=j;
                temp=j;
            else
                m=m+1;
                codes(i,m)=j-temp;
                temp=j;
            end
            %----��¼�����غ���һ����¼��ľ���-----%
            minst(i)=m;  % ��minst�м�¼���еĵ���
        end
    end
end

%----------------------����ģ��Ĵ�С-----------------------------------------------------------------------%
%-------�������code�е�һ�е�ƽ��ֵ������8�����������Ϊһ��ģ��ĳ���aunit----------------%
asum=0;
for i=1:k+1
    asum=asum+codes(i,1);
end
aunit = round(asum/(k+1)/8);
%------------------------------------------------------------------------------------------%
%-------------code��������aunit�������������ܵȵõ������ķ�������------------------------%
acodes= zeros(k+1,minst(1));
for i=1:k+1
    for j=1:minst(1)
        acodes(i,j)=round(codes(i,j)/aunit);
    end
end
%------------------------------------------------------------------------------------------%        
[r,s]=size(acodes);
%r
%s
%acodes
end

