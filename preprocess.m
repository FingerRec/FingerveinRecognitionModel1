function  out = preprocess(img)
global HSIZE SIGMA THRESH


HSIZE = [5 5];
SIGMA = 1; 
THRESH = [0.04 0.2];

[m,n] = size(img);
if m > n
    img = imrotate(img,-90);
end
%高斯滤波参数
if(ndims(img)==3)
    grayimg = rgb2gray(img);
else
    grayimg = img;
end

grayimg = im2double(grayimg);
%grayimg = grayimg(80:380, 150:450);
%灰度化处理
%subplot(1,3,1),imshow(grayimg);

%高斯低通滤波去噪
gausFilter = fspecial('gaussian',HSIZE,SIGMA);
filtimg = imfilter(grayimg,gausFilter,'replicate');

%figure;
%imshow(filtimg);

%边缘检测
edgeimg = edge(filtimg,'canny',THRESH);
%edgeimg = edge(filtimg, 'sobel', 'horizontal');
%edgeimg = edge(filtimg,'prewitt','horizontal');
%subplot(1,3,2),imshow(edgeimg);
%se1 = strel('disk', 1);
%se2 = strel('disk', 2);

%edgegetimg = imdilate(edgeimg,se1); %膨胀
%edgegetimg = imerode(edgegetimg,se2);%腐蚀
%figure;imshow(edgegetimg);

%图像提取,获取边界内的图像
%imfill(edgeimg,'holes')

%测试第二次
%[minrow maxrow mincol maxcol] = getfinger(edgegetimg);
%preimg = filtimg(minrow:maxrow,mincol:maxcol);
preimg = filtimg;
%图像归一化

%灰度归一化,双线性插值法
p = max(max(preimg(:,:))) - min(min(preimg(:,:)));
y = double(1/double(p));
preimg(:,:) = double((double(y) * double((preimg(:,:) - min(min(preimg(:,:)))))));
%figure,imshow(preimg);
%{
thresolad = 0.25;
erzhi=im2bw(preimg,thresolad);  %二值化
figure, imshow(erzhi);
xihua=bwmorph(erzhi,'thin',Inf);%对图像进行细化
figure;imshow(xihua);
%}
%尺寸归一化,归一化大小为96x64的

[m,n] = size(preimg);
s = [double(96/n) 0 0; 0 double(64/m) 0; 0 0 1];
tform = maketform('affine', double(s));
normalizedimg = imtransform(preimg, tform, 'XData', [1 96], 'YData', [1 64], 'FillValue', 0);
[m,n] = size(normalizedimg);
%subplot(1,3,3),imshow(normalizedimg);
%方向分割，突出特征
segmfigure = sixfenge(normalizedimg,10);
lvbofigure = medfilt2(segmfigure);
shuchu = lvbo(lvbofigure,50);
shuchu = im2bw(shuchu);

%se1 = strel('disk', 1);
%se2 = strel('disk', 3);

%edgegetimg = imdilate(shuchu,se1); %膨胀
%edgegetimg = imerode(edgegetimg,se2);%腐蚀

%use = endpoints(shuchu);
%figure,imshow(shuchu);

%腐蚀运算，让骨骼清晰
 %se1=strel('disk',1);%这里是创建一个半径为3的平坦型圆盘结构元素
 %shuchu=imerode(shuchu,se1);

%figure;
%imshow(segmfigure);
%figure;
%imshow(lvbofigure);
%figure;
%imshow(shuchu);
%afterimg = medfilt2(afterimg);

%erzhi=fenge(afterimg)  %二值化
%xihua=bwmorph(shuchu,'thin',Inf);%对图像进行细化
%figure;imshow(xihua);
%yy1=smoothTO(xihua);
%yy1=smooth(xihua,30,'lowess');	
%figure,imshow(yy1);
%out = edgegetimg;
out = shuchu;