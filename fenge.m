function J = fenge(I)
tmin=min(I(:));

tmax=max(I(:));
th=(tmin+tmax)/2;
%���ҶȾ�ֵ
ok=true;
%����������ֵ
while ok
     g1=I>=th; %�Ҷ�ֵ���ϵĵ�
     g2=I<th; %ƽ���Ҷ�ֵ���µĵ�
     u1=mean(I(g1));%�Ҷ�ֵ���µ�ľ�ֵ
     u2=mean(I(g2));%�Ҷ�ֵ���ϵ�ľ�ֵ
     thnew=(u1+u2)/2;%��������ֵ
     ok=abs(th-thnew)>=1;
     th=thnew;
end

th=floor(th);
J=im2bw(I,th/255);
%{
figure(1);
imshow(I);
title('ԭʼͼƬ');
figure(2);
str=['�����ָ��ֵ Th=',num2str(th)];
imshow(J);
title(str);
%}
end