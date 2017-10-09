function [ dcodes ] = symbolToNumber(acodes)
load symcodes.mat -ascii
%display('8.ת����������Ϊ���������֣��������� �� �������֣�')
[row,col] = size(acodes);
%����acode�У�ǰ16�кͺ�17�зֱ�����ʼ������ֹ�������������Ų�Я�����֣����Գ�ȥ��
acodes = acodes(:,17:col-17);
%acodes
[row,col] = size(acodes);
dcodes = zeros(1, round(row*col/8));
k = 0;
for i=1:row
    for j=1:8:col
        %��������code��ÿ��(i,j)��ȡ8����
        temp = acodes(i,j)*10000000 + acodes(i,j+1)*1000000 + acodes(i,j+2)*100000 + acodes(i,j+3)*10000 + acodes(i,j+4)*1000 + acodes(i,j+5)*100 + acodes(i,j+6)*10 + acodes(i,j+7);
        %����PDF417�ķ���ת�����������ҳ�temp����Ӧ������
        for m=1:3
            for n=1:929
                if symcodes(m,n) == temp
                    k=k+1;
                    dcodes(k)=n-1;
                    break;
                end
            end
        end
    end
end
%dcodes
end

