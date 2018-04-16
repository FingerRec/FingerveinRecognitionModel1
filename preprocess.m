function  out = preprocess(img)
global HSIZE SIGMA THRESH


HSIZE = [5 5];
SIGMA = 1; 
THRESH = [0.04 0.2];

[m,n] = size(img);
if m > n
    img = imrotate(img,-90);
end
%��˹�˲�����
if(ndims(img)==3)
    grayimg = rgb2gray(img);
else
    grayimg = img;
end

grayimg = im2double(grayimg);
%grayimg = grayimg(80:380, 150:450);
%�ҶȻ�����
%subplot(1,3,1),imshow(grayimg);

%��˹��ͨ�˲�ȥ��
gausFilter = fspecial('gaussian',HSIZE,SIGMA);
filtimg = imfilter(grayimg,gausFilter,'replicate');

%figure;
%imshow(filtimg);

%��Ե���
edgeimg = edge(filtimg,'canny',THRESH);
%edgeimg = edge(filtimg, 'sobel', 'horizontal');
%edgeimg = edge(filtimg,'prewitt','horizontal');
%subplot(1,3,2),imshow(edgeimg);
%se1 = strel('disk', 1);
%se2 = strel('disk', 2);

%edgegetimg = imdilate(edgeimg,se1); %����
%edgegetimg = imerode(edgegetimg,se2);%��ʴ
%figure;imshow(edgegetimg);

%ͼ����ȡ,��ȡ�߽��ڵ�ͼ��
%imfill(edgeimg,'holes')

%���Եڶ���
%[minrow maxrow mincol maxcol] = getfinger(edgegetimg);
%preimg = filtimg(minrow:maxrow,mincol:maxcol);
preimg = filtimg;
%ͼ���һ��

%�Ҷȹ�һ��,˫���Բ�ֵ��
p = max(max(preimg(:,:))) - min(min(preimg(:,:)));
y = double(1/double(p));
preimg(:,:) = double((double(y) * double((preimg(:,:) - min(min(preimg(:,:)))))));
%figure,imshow(preimg);
%{
thresolad = 0.25;
erzhi=im2bw(preimg,thresolad);  %��ֵ��
figure, imshow(erzhi);
xihua=bwmorph(erzhi,'thin',Inf);%��ͼ�����ϸ��
figure;imshow(xihua);
%}
%�ߴ��һ��,��һ����СΪ96x64��

[m,n] = size(preimg);
s = [double(96/n) 0 0; 0 double(64/m) 0; 0 0 1];
tform = maketform('affine', double(s));
normalizedimg = imtransform(preimg, tform, 'XData', [1 96], 'YData', [1 64], 'FillValue', 0);
[m,n] = size(normalizedimg);
%subplot(1,3,3),imshow(normalizedimg);
%����ָͻ������
segmfigure = sixfenge(normalizedimg,10);
lvbofigure = medfilt2(segmfigure);
shuchu = lvbo(lvbofigure,50);
shuchu = im2bw(shuchu);

%se1 = strel('disk', 1);
%se2 = strel('disk', 3);

%edgegetimg = imdilate(shuchu,se1); %����
%edgegetimg = imerode(edgegetimg,se2);%��ʴ

%use = endpoints(shuchu);
%figure,imshow(shuchu);

%��ʴ���㣬�ù�������
 %se1=strel('disk',1);%�����Ǵ���һ���뾶Ϊ3��ƽ̹��Բ�̽ṹԪ��
 %shuchu=imerode(shuchu,se1);

%figure;
%imshow(segmfigure);
%figure;
%imshow(lvbofigure);
%figure;
%imshow(shuchu);
%afterimg = medfilt2(afterimg);

%erzhi=fenge(afterimg)  %��ֵ��
%xihua=bwmorph(shuchu,'thin',Inf);%��ͼ�����ϸ��
%figure;imshow(xihua);
%yy1=smoothTO(xihua);
%yy1=smooth(xihua,30,'lowess');	
%figure,imshow(yy1);
%out = edgegetimg;
out = shuchu;