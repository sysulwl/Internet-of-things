function [x1,x2,y1,y2] =cutCode( ost )
display('2.分离条码图像')
[new_row,new_col]=size(ost);
hvalues=sum(ost');
figure,plot(hvalues);
title('每一行的灰度值之和')
T=new_col*255/1.45
%找到图像顶边
topedge = 0;
for i=2:new_row-5
    if (hvalues(i-1)>T) && (hvalues(i)<T) && (hvalues(i+1)<T) && (hvalues(i+2)<T) && (hvalues(i+3)<T) && (hvalues(i+4)<T) && (hvalues(i+5)<T)
        topedge=i;
        break;
    end
end
%找到图像底边
for i=topedge:new_row-3
    if (hvalues(i-1)<T) && (hvalues(i)<T) && (hvalues(i+1)>T) && (hvalues(i+2)>T) && (hvalues(i+3)>T)
        botedge=i;
        break;
    end
end
topedge
botedge
%由上边线寻找左上角端点
midpit=round((topedge+botedge)/2)
for j=3:new_col-5
    if (ost(midpit,j-2)>200) && (ost(midpit,j-1)>200) && (ost(midpit,j)<10) && (ost(midpit,j+1)<10) && (ost(midpit,j+2)<10) && (ost(midpit,j+3)<10) && (ost(midpit,j+4)<10)
        x1=topedge;
        y1=j;
        break;
    end
end
%由下边线寻找右下角
for j=new_col-5:-1:y1+1
    if (ost(midpit,j+5)>200) && (ost(midpit, j+4)>200) && (ost(midpit, j+3)>200) && (ost(midpit, j+2)>200) && (ost(midpit,j+1)>200) && (ost(midpit,j)<10) && (ost(midpit,j-1)<10)
        x2=botedge;
        y2=j;
        break;
    end
end
% %由上边线寻找左上角端点
% for j=2:new_col-5
%     if (ost(topedge,j-1)>200) && (ost(topedge,j)<10) && (ost(topedge,j+1)<10) && (ost(topedge,j+2)<10) && (ost(topedge,j+3)<10) && (ost(topedge,j+4)<10) && (ost(topedge+2,j+2)<10) && (ost(topedge+3,j+3)<10)
%         x1=topedge;
%         y1=j;
%         break;
%     end
% end
% %由下边线寻找右下角
% for j=y1+1:new_col-5
%     if (ost(botedge-1,j-1)<10) && (ost(botedge-1,j)<10) && (ost(botedge,j+1)>200) && (ost(botedge,j+2)>200) && (ost(botedge,j+3)>200) && (ost(botedge,j+4)>200) && (ost(botedge+2,j+2)>200) && (ost(botedge+3,j+3)>200)
%         x2=botedge;
%         y2=j;
%     end
% end
%分离条码图像

end

