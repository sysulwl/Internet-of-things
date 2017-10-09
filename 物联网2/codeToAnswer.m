function [ str ] = codeToAnswer(dcodes);
%�ı�ģʽ���TC,������ֵ��Asciiֵ��֮���Բ�ֱ�Ӵ���ַ�������Ϊ��ЩAsciiֵ�޷���ʾ������LF��CR��
%��ģʽת�����Ŷ������ֵ,���£�
%ll=201������ΪСд��ĸģʽ
%ml=202������Ϊ���ģʽ
%pl=203������Ϊ���ģʽ
%al=200������Ϊ��д��ĸģʽ
%ps=204��ת��Ϊ���ģʽ
%as=205��ת��Ϊ��д��ĸģʽ
tc_uc=[65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,32,201,202,204];%��д��ĸģʽ
tc_lc=[97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,32,205,202,204];%Сд��ĸģʽ
tc_mi=[48,49,50,51,52,53,54,55,56,57,38,13,09,44,58,35,45,46,36,47,43,37,42,61,94,203,32,201,200,204];%�����ģʽ
tc_do=[59,60,62,64,91,92,93,95,96,126,33,13,09,44,58,10,45,46,36,47,34,124,42,40,41,63,123,125,39,200];%�����ģʽ
%����ģʽ���
nc_tb=[48,49,50,51,52,53,54,55,56,57];
%��ʼ���룬��ʱ��֧���ֽ���ģʽ��ֻ֧���ı�ģʽ������ģʽ
codelen=dcodes(1);  %���������ֳ���
mode=11;  % 2->�����͡�3->�ֽ��͡�11->�ı�ģʽ��д�͡�12->�ı�ģʽСд�͡�13->�ı�ģʽ����͡�14->�ı�ģʽ�����
premode=[0,0];% ����ת��ģʽʱ��¼ģʽֵ,��һ��ֵΪ1��0����ʾ��ǰ�ǣ���ת��ģʽ���ڶ���ֵ��ʾҪ���ص�ģʽֵ
tcbyte=zeros(1,2);% ���ڼ�¼�ı�ģʽʱ�ĸߵ�λ���ݣ���һ��ֵ��ʾ��λ���ݣ��ڶ���ֵ��ʾ��λ����
valueindex=[0,0];% ���ڼ�¼�ֽ�ģʽ������ģʽ�Ļ������У����е�һ��ֵ��ʾ�����Ƿ���Ч������ģʽ 0->��Ч��1->����ģʽ��2->�ֽ�ģʽ���ڶ���ֵ��ʾ������ʼλ��
str=''; % ���������
for i=2:codelen
    if dcodes(i) >= 900
        if dcodes(i) == 900
            mode = 11;   % 11->�ı�ѹ��ģ��
        elseif dcodes(i)==902
            mode = 2;    % 2->����ѹ����
        elseif (dcodes(i)==901) || (dcodes(i)==924) || (dcodes(i)==913)
            mode = 3;    % 3->�ֽ�ѹ����
        end
        
        %����ѹ��ģʽ����
        if valueindex(1) == 1
            caches = dcodes(valueindex(2):(i-1)); %����ѹ��ģʽ�µĴ���������
            len = size(caches,2);
            
            for k=1:15:len
                curvalues=zeros(1,15); %�����洢15������
                if (k+14)<len %��ǰ�����15������
                    curvalues = caches(k:k+14);
                else          %��ǰ�鲻��15������
                    curvalues(k+15-len:15) = caches(k:len);
                end
                %��ʼ����
                longnum=0;
                for x=1:15
                    %�����÷������㣬������Ч�����ֻ��16λ
                    %��curvaluesִ�дӻ�900����10��ת����ת��������浽longnum
                    longnum = longnum+curvalues(x)*sym(9^(15-x))*(100^(15-x)); 
                end
                tempstr=char(longnum); %ת�����ַ�
                str = strcat(str, tempstr(2:end)); %���ӵ�str��
            end
        end
             
        valueindex = [0,0];
        
    else
       
        %----------------�ı�ѹ��ģʽ����----------------%
        if mode > 10
            % �����λ�ַ��͵�λ�ַ����浽tcbyte�У�һ�����ֿ��Ա�ʾһ���ַ��ԣ�  ���� = 30 * H + L
            tcbyte(1)=floor(dcodes(i)/30);  % H
            tcbyte(2)=dcodes(i) - tcbyte(1)*30; % L
            for j=1:2
                if mode==11  % ��д��ĸ
                    if premode(1) == 1
                        mode = premode(2);
                        premode(1) = 0;
                    end
                    if tc_uc(tcbyte(j)+1) == 201 % ����ΪСд��ĸ����ģʽ
                        mode = 12;
                    elseif tc_uc(tcbyte(j)+1) == 202 % ����Ϊ�������ģʽ
                        mode=13;
                    elseif tc_uc(tcbyte(j)+1) == 204 % ת�Ƶ����ģʽ
                        premode(1)=1;
                        premode(2)=mode;
                        mode=14;
                    else
                        str = strcat(str,char(tc_uc(tcbyte(j)+1))); % ��ӵ��������ַ�����
                    end
                elseif mode == 12 % Сд��ĸ
                    if premode(1) == 1
                        mode = premode(2);
                        premode(1)=0;
                    end
                    if tc_lc(tcbyte(j)+1) == 205 % ת�Ƶ���д��ĸ����ģʽ
                        premode(1) = 1;
                        premode(2) = mode;
                        mode = 11;
                    elseif tc_lc(tcbyte(j)+1) == 202 % ����Ϊ�������ģʽ
                        mode = 13;
                    elseif tc_lc(tcbyte(j)+1) == 204  % ת�Ƶ����ģʽ
                        premode(1) = 1;
                        premode(2) = mode;
                        mode = 14;
                    else
                        str = strcat(str,char(tc_lc(tcbyte(j)+1))); % ��ӵ��������ַ�����
                    end
                elseif mode == 13 % �������ģʽ
                    if premode(1 )== 1
                        mode = premode(2);
                        premode(1) = 0;
                    end
                    if tc_mi(tcbyte(j)+1) == 200 % ����Ϊ��д��ĸģʽ
                        mode = 11;
                    elseif tc_mi(tcbyte(j)+1) == 201 % ת�Ƶ�Сд��ĸ����ģʽ
                        mode = 12;
                    elseif tc_mi(tcbyte(j)+1) == 203 % ����Ϊ���ģʽ
                        mode = 14;
                    elseif tc_mi(tcbyte(j)+1) == 204 % ת�Ƶ����ģʽ
                        premode(1) = 1;
                        premode(2) = mode;
                        mode = 14;
                    else
                        str = strcat(str,char(tc_mi(tcbyte(j)+1)));  % ��ӵ��������ַ�����
                    end
                elseif mode == 14 %���
                    if premode(1)==1
                        mode = premode(2);
                        premode(1) = 0;
                    end
                    if tc_do(tcbyte(j)+1) == 200  % ����Ϊ��д��ĸģʽ
                        mode=11;
                    else
                        str = strcat(str,char(tc_do(tcbyte(j)+1)));  % ��ӵ��������ַ�����
                    end
                end
            end
        %----------------�ı�ѹ��ģʽ����----------------%
            
        elseif mode == 2
            if valueindex(1) == 0
                valueindex(1) = 1; % ����ģʽ
                valueindex(2) = i;
            end
        elseif mode == 3   % Ӧ�����ֽ��ͣ�ignore������
            if valueindex(1) == 0
                valueindex(1) = 2;
                valueindex(2) = i;
            end
        end
    end
end
%disp(['����������Ϊ��',str])
end

