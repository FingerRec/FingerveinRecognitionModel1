%指纹静脉识别系统
%时间：2016.8.2


clc;
clear;
close all;


img = imread('E:\Personal\Desktop\开发资料\指纹静脉\dataset_617574\617574\FV_samples\F2804.bmp');
%img2 = imread('D:\Personal\Desktop\指纹静脉\dataset_617574\617574\FV_samples\F0105.bmp');

list=dir(['E:\Personal\Desktop\开发资料\指纹静脉\dataset_617574\617574\FV_samples\','*.bmp']);
k=length(list);
for i=420:1:k
str= strcat ('E:\Personal\Desktop\开发资料\指纹静脉\dataset_617574\617574\FV_samples\', list(i).name);
img2 = imread(str);
%img2 = imread('D:\Personal\Desktop\指纹静脉\dataset_617574\617574\FV_samples\F1006.bmp');
fprintf('预处理时间是:');
tic;
processimage = preprocess(img);
template = preprocess(img2);
toc;
%figure,imshow(img);
%figure,imshow(img2);
%a = size(regionprops(processimage))
%b = size(regionprops(template))
fprintf('匹配时间是:');
tic;
result = match(processimage,template);
toc;
sp=actxserver('SAPI.SpVoice');
if result == 1
    sp.Speak('匹配成功');
else
     sp.Speak('匹配失败');
end
end
