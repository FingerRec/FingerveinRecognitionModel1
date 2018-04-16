function shuchu = sixfenge(tuxiang,t)
%preprocess中调用，提取方向信息，NiBlack分割，输出二值图像
tt=4;
[m,n]=size(tuxiang);
kuozhantu=zeros(m+2*tt,n+2*tt);
junzhi=zeros(1,8);
diff=zeros(1,4);
kuozhantu(tt+1:m+tt,tt+1:n+tt)=tuxiang(:,:);
kongjuzhen1=zeros(m,n);
kongjuzhen2=zeros(m,n);
kongjuzhen3=zeros(m,n);
%shuchutuxiang=zeros(m,n);
fangxiang(:,:,1)=[0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  3 0 -1 0 -4 0 -1 0 3;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0];
fangxiang(:,:,5)=fangxiang(:,:,1)';
fangxiang(:,:,2)=[0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  3 0 0 0 0 0 0 0 0;
                  0 0 -1 0 0 0 0 0 0;
                  0 0 0 0 -4 0 0 0 0;
                  0 0 0 0 0 0 -1 0 0;
                  0 0 0 0 0 0 0 0 3;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0];
fangxiang(:,:,4)=fangxiang(:,:,2)';
fangxiang(:,:,3)=[3 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 -1 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 -4 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 -1 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 3];
fangxiang(:,:,7)=[0 0 0 0 0 0 0 0 3;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 -1 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 -4 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 -1 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  3 0 0 0 0 0 0 0 0];
fangxiang(:,:,8)=[0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 3;
                  0 0 0 0 0 0 -1 0 0;
                  0 0 0 0 -4 0 0 0 0;
                  0 0 -1 0 0 0 0 0 0;
                  3 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0];
fangxiang(:,:,6)=fangxiang(:,:,8)';
%提取方向信息
for i=tt+1:m+tt
    for j=tt+1:n+tt
        for l=1:8
            junzhi(l)=sum(sum(kuozhantu(i-tt:i+tt,j-tt:j+tt).*fangxiang(:,:,l)))/7;
        end
        for k=1:8
            diff(k)=junzhi(k);
        end
        [maxx fx]=max(diff);
        kongjuzhen2(i-tt,j-tt)=maxx;
        if maxx>0
            kongjuzhen1(i-tt,j-tt)=maxx;
        else
            kongjuzhen1(i-tt,j-tt)=0;
        end
    end
end
%figure, imshow(kongjuzhen1);

%NiBlack分割
kongjuzhen=zeros(m+2*t,n+2*t);
kongjuzhen(t+1:m+t,t+1:n+t)=kongjuzhen1;
for i=t+1:m+t
    for j=t+1:n+t
        if kongjuzhen1(i-t,j-t)~=0
            ave=sum(sum(kongjuzhen(i-t:i+t,j-t:j+t)))/((2*t+1).^2);
            d=sqrt((sum(sum((kongjuzhen(i-t:i+t,j-t:j+t)-ave).^2)))/((2*t+1).^2));
            ave = ave + 0.05*d;%0.05修正系数
            if kongjuzhen1(i-t,j-t)>=ave
                kongjuzhen3(i-t,j-t)=1;
            else
                kongjuzhen3(i-t,j-t)=0;
            end
        end
    end
end
shuchu=kongjuzhen3;