function [y]=smoothTO(x)
[m,n]=size(x);
coef1=[31 9 -3 -5 3]/35;
for j=1:n
    y(1,j)=coef1(1)*x(1,j)+coef1(2)*x(2,j)+coef1(3)*x(3,j)+coef1(4)*x(4,j)+coef1(5)*x(5,j);
end
coef2=[9 13 12 6 -5]/35;
for j=1:n
    y(2,j)=coef2(1)*x(1,j)+coef2(2)*x(2,j)+coef2(3)*x(3,j)+coef2(4)*x(4,j)+coef2(5)*x(5,j);
end
coef3=[-3 12 17 12 -3]/35;
for j=1:n
    for i=3:m-2
        y(i,j)=coef3(1)*x(i-2,j)+coef3(2)*x(i-1,j)+coef3(3)*x(i,j)+coef3(4)*x(i+1,j)+coef3(5)*x(i+2,j);
    end
end
coef4=[-5 6 12 13 9]/35;
for j=1:n
    y(m-1,j)=coef4(1)*x(m-4,j)+coef4(2)*x(m-3,j)+coef4(3)*x(m-2,j)+coef4(4)*x(m-1,j)+coef4(5)*x(m,j);
end
coef5=[3 -5 -3 9 31]/35;
for j=1:n
    y(m,j)=coef5(1)*x(m-4,j)+coef5(2)*x(m-3,j)+coef5(3)*x(m-2,j)+coef5(4)*x(m-1,j)+coef5(5)*x(m,j);
end