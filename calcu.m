function [endp1,fork1,endpoint,forkpoint] = calcu(input)

global ge forknum
ge = 1;
forknum = 2;
%fork为大于周围的点数
[m,n] = size(input);

endpoint = 0;
forkpoint= 0;

%存储端点
endp1 = zeros(m,n);
%存储叉点
fork1 = zeros(m,n);

temp = 0;
for i = 1+ge:m-ge
    for j = 1+ge:n-ge
        temp = 0;
        if(input(i,j))
            temp = abs(input(i-ge,j) - input(i-ge,j-ge)) + abs(input(i-ge,j+ge) - input(i-ge,j)) + abs(input(i,j+ge) - input(i-ge,j+ge))+ abs(input(i+ge,j+ge) - input(i,j+ge))+ abs(input(i+ge,j) - input(i+ge,j+ge))+ abs(input(i+ge,j-ge) - input(i+ge,j));
            temp = temp + abs(input(i,j-ge) - input(i+ge,j-ge)) + abs(input(i-ge,j-ge) - input(i,j-ge));
            if(temp <= 7) endpoint = endpoint + 1; endp1(i,j) = 1; 
            end
            if(temp>=forknum && temp <=5) forkpoint = forkpoint + 1; fork1(i,j) = 1;
            end
        end
    end
end

