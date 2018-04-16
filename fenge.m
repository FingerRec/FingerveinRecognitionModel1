function J = fenge(I)
tmin=min(I(:));

tmax=max(I(:));
th=(tmin+tmax)/2;
%做灰度均值
ok=true;
%迭代计算阈值
while ok
     g1=I>=th; %灰度值以上的点
     g2=I<th; %平均灰度值以下的点
     u1=mean(I(g1));%灰度值以下点的均值
     u2=mean(I(g2));%灰度值以上点的均值
     thnew=(u1+u2)/2;%两个的中值
     ok=abs(th-thnew)>=1;
     th=thnew;
end

th=floor(th);
J=im2bw(I,th/255);
%{
figure(1);
imshow(I);
title('原始图片');
figure(2);
str=['迭代分割：阈值 Th=',num2str(th)];
imshow(J);
title(str);
%}
end