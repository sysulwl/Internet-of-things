function result=dilateandcorrode(origin_image,cons,X,Y,tag)
% ���͸�ʴ���ú���
% origin_image��Ҫ���в�����ͼ��
% cons�ǽṹ��Ԫ�أ�XY��ԭ��λ��
[width,height]=size(origin_image);
[cons_width,cons_height]=size(cons);
result=zeros(width,height);
if tag==1 %����
    for y=1:height               
       for x=1:width%����ԭͼ���ÿһ�����ص�
           if origin_image(x,y)==1%����õ�ֵΪ1
               for i=1:cons_width%�ٱ����ṹ��
                   for j=1:cons_height
                       if cons(i,j)==1&&~(x-X+i<=0||x-X+i>width||y-Y+j<=0||y-Y+j>height)  %����ṹ���Ӧλ�õ�ֵΪ1�Ҳ�Խ��        
                           result(x-X+i,y-Y+j)=1;%���ͼ�ж�Ӧλ�õ�ֱֵ����Ϊ1
                       end
                   end
               end
               result(x,y)=1;%ԭ��λ��ҲҪ��Ϊ1
           end
       end
    end
else
    for y=1:height %��ʴ����������ͬ��
       for x=1:width
           value=1;
           if origin_image(x,y)==1
               for i=1:cons_width
                   for j=1:cons_height
                       if cons(i,j)==1 && ~(x-X+i<=0||x-X+i>width||y-Y+j<=0||y-Y+j>height)
                           if origin_image(x-X+i,y-Y+j)==0%���ԭͼ���Ӧ��ֵ��ṹ��ֵ��һ��
                               value=0;
                           end
                       end
                   end
               end
               result(x,y)=value;%ԭ��λ��Ҫ��Ϊ0
           end
       end
    end
end
end