function [minrow ,maxrow, mincol, maxcol] = getfinger(h1)
%guiyihua中调用，从边界图像中，内切提取内边界的值
[m,n] = size(h1);


for i = 1:m
    h1(i,320)
    if h1(i,320) && i < floor(m/2)
        minrow = i +25;
    end
    if h1(i,320) > 0 && i >= floor(m/2)
        maxrow = i - 25;
    end
end

for j = 1:n
    if h1(240,j) > 0 && j < floor(n/2)
        mincol = j + 105;
    end
    if h1(240,j) > 0 && j >= floor(n/2)
        maxcol = j - 115;
    end
end
