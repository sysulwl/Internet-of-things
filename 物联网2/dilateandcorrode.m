function result=dilateandcorrode(origin_image,cons,X,Y,tag)
% 膨胀腐蚀调用函数
% origin_image是要进行操作的图像
% cons是结构体元素，XY是原点位置
[width,height]=size(origin_image);
[cons_width,cons_height]=size(cons);
result=zeros(width,height);
if tag==1 %膨胀
    for y=1:height               
       for x=1:width%遍历原图像的每一个像素点
           if origin_image(x,y)==1%如果该点值为1
               for i=1:cons_width%再遍历结构体
                   for j=1:cons_height
                       if cons(i,j)==1&&~(x-X+i<=0||x-X+i>width||y-Y+j<=0||y-Y+j>height)  %如果结构体对应位置的值为1且不越界        
                           result(x-X+i,y-Y+j)=1;%结果图中对应位置的值直接置为1
                       end
                   end
               end
               result(x,y)=1;%原点位置也要置为1
           end
       end
    end
else
    for y=1:height %腐蚀遍历与膨胀同理
       for x=1:width
           value=1;
           if origin_image(x,y)==1
               for i=1:cons_width
                   for j=1:cons_height
                       if cons(i,j)==1 && ~(x-X+i<=0||x-X+i>width||y-Y+j<=0||y-Y+j>height)
                           if origin_image(x-X+i,y-Y+j)==0%如果原图像对应的值与结构体值不一致
                               value=0;
                           end
                       end
                   end
               end
               result(x,y)=value;%原点位置要置为0
           end
       end
    end
end
end