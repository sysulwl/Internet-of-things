function [ dcodes ] = symbolToNumber(acodes)
load symcodes.mat -ascii
%display('8.转换符号码字为待解码码字（符号码字 到 数字码字）')
[row,col] = size(acodes);
%矩阵acode中，前16列和后17列分别是起始符和终止符，这两个符号不携带码字，可以除去。
acodes = acodes(:,17:col-17);
%acodes
[row,col] = size(acodes);
dcodes = zeros(1, round(row*col/8));
k = 0;
for i=1:row
    for j=1:8:col
        %遍历矩阵code，每从(i,j)处取8个数
        temp = acodes(i,j)*10000000 + acodes(i,j+1)*1000000 + acodes(i,j+2)*100000 + acodes(i,j+3)*10000 + acodes(i,j+4)*1000 + acodes(i,j+5)*100 + acodes(i,j+6)*10 + acodes(i,j+7);
        %历遍PDF417的符号转换表，在其中找出temp所对应的码字
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

