%ָ�ƾ���ʶ��ϵͳ
%ʱ�䣺2016.8.2


clc;
clear;
close all;


img = imread('E:\Personal\Desktop\��������\ָ�ƾ���\dataset_617574\617574\FV_samples\F2804.bmp');
%img2 = imread('D:\Personal\Desktop\ָ�ƾ���\dataset_617574\617574\FV_samples\F0105.bmp');

list=dir(['E:\Personal\Desktop\��������\ָ�ƾ���\dataset_617574\617574\FV_samples\','*.bmp']);
k=length(list);
for i=420:1:k
str= strcat ('E:\Personal\Desktop\��������\ָ�ƾ���\dataset_617574\617574\FV_samples\', list(i).name);
img2 = imread(str);
%img2 = imread('D:\Personal\Desktop\ָ�ƾ���\dataset_617574\617574\FV_samples\F1006.bmp');
fprintf('Ԥ����ʱ����:');
tic;
processimage = preprocess(img);
template = preprocess(img2);
toc;
%figure,imshow(img);
%figure,imshow(img2);
%a = size(regionprops(processimage))
%b = size(regionprops(template))
fprintf('ƥ��ʱ����:');
tic;
result = match(processimage,template);
toc;
sp=actxserver('SAPI.SpVoice');
if result == 1
    sp.Speak('ƥ��ɹ�');
else
     sp.Speak('ƥ��ʧ��');
end
end
