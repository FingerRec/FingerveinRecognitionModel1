function result = match(input,input2);

%细节点匹配，端点和交叉点匹配
%而后用hausdorff相似度匹配算法

global ge forknum endpoint forkpoint endpoint2 forkpoint2 endp1 endp2 fork1 fork2 zeropointnuma zeropointnumb  endthre forkthre  ipthresold maxipthresold hd hd2
ge = 2;
forknum = 5;
endthre = 100;
forkthre = 100;
ipthresold = 5.50;
maxipthresold = 6.00;
%fork为大于周围的点数
[m,n] = size(input);

%input = smoothTO(input);
%input2 = smoothTO(input2);
endpoint = 0;
forkpoint= 0;
endpoint2=0;
forkpoint2=0;
%存储端点
endp1 = zeros(m,n);
endp2 = zeros(m,n);
%存储叉点
fork1 = zeros(m,n);
fork2 = zeros(m,n);

[endp1,fork1,endpoint,forkpoint] = calcu(input);
[endp2,fork2,endpoint2,forkpoint2] = calcu(input2);
zeropointnuma = sum(input(:)==0);
zeropointnumb = sum(input2(:)==0);
%a = sum(input(:)==0)
%b = sum(input2(:)==0)
%figure,imshow(input);

%%{
se1=strel('disk',4);
B=[1 1 1 1
 1 1 1 1
  1 1 1 1
  1 1 1 1];
%endp1=imdilate(endp1,B);%图像A1被结构元素B膨胀
%endp2=imdilate(endp2,B);
%fork1=imdilate(fork1,se1);
%ork2=imdilate(fork2,se1);
%%}
%pic=cat(1,endp1,fork1);
%figure;montage(pic)
%figure,imshow(endp1);
%figure,imshow(fork1);
pic=cat(1,endp2,fork2);
%figure;montage(pic)
%fork2 = smooth(fork2,30,'lowess');	
%fork2 = smoothTO(fork2);
%figure,subplot(1,2,1);imshow(endp2);subplot(1,2,2);imshow(fork2);

hd3 = HausdorffDist2(input,input2);
%hd4 = pdist2(input,input2);
%hd4=  mahal(input',input2');

if(abs(endpoint - endpoint2) <endthre && abs(forkpoint-forkpoint2)<forkthre)
[hd,hd2,result] = judge(endp1,fork1,endp2,fork2,zeropointnuma,zeropointnumb);
else result = 0;
end

if(hd3 < ipthresold)
    result = 1; 
elseif (hd3 > maxipthresold) result = 0;    
end

%fid = fopen('D:\Personal\Desktop\指纹静脉\FingerVein\result.txt','at+');
%fprintf(fid,'With distance at %.2f,the result is HausdorffDist:%.2f ,%.2f ,endpointSub(a-b):%.2f ,forkpointSub(a-b):%.2f ;,hd3 is:%.2f\n',ge,hd,hd2,abs(endpoint - endpoint2),abs(forkpoint-forkpoint2),hd3);
%fclose(fid);

end
