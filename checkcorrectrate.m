%判断识别率
%FRR
%FIR
function checkcorrectrate
global allnumber correctnumber checknumber  correctrate recgrate  choosenum  dividnum  minrecg maxrecg
 tic;
allnumber = 0;%所有检查了的图像
correctnumber =0;%检查了的图像中匹配并且正确的
checknumber = 0;%检查了的图像中匹配的
list=dir(['D:\Personal\Desktop\指纹静脉\dataset_617574\617574\FV_samples\','*.bmp']);
k=length(list);
correctrate = zeros(k);%识别正确率
recgrate = zeros(k);%识别率;
choosenum = 15; %每幅图像重复的
dividnum = 1; %数据库中重复的
minrecg = +inf; % 表示两幅图最小相差度
maxrecg = 0; %表示哪一幅匹配的图
 for i=1:k
     str= strcat ('D:\Personal\Desktop\指纹静脉\dataset_617574\617574\FV_samples\', list(i).name);
     image = imread(str);
     image = preprocess(image);
     zeropointnum = sum(image(:)==0);%0点个数
     [endp1,fork1,endpoint,forkpoint] = calcu(image);
    minrecg = +inf; % 表示两幅图最小相差度
    maxrecg = 0; %表示哪一幅匹配的图
  %  tic;
     allnumber = allnumber + 1;
      if (exist('database.dat')==2)
        load('database.dat','-mat');
        for scanning = 1 : fp_number   
            [v1,v2,result] = judge(endp1,fork1,data{scanning,1},data{scanning,2},zeropointnum,data{scanning,5});
            if(result == 1 && v1 < minrecg) minrecg = v1; maxrecg = scanning; end     
%        else
%            message=strcat('There are no figure simliar, please choose anthoer;');
%            msgbox(message,'DataBase Info','help');
      %      break;
        end  
         if(minrecg < 10)
                checknumber = checknumber + 1; 
            %向上取整
            if  ceil(i/choosenum) <= (ceil(maxrecg/dividnum) + 2) && ceil(i/choosenum) >= (ceil(maxrecg/dividnum) - 2);
                correctnumber = correctnumber + 1;
            end     
             fprintf('第%.2f张图片识别后，所有数目是：%.2f,识别数目是:%.2f ，识别正确数目是:%.2f,',i,allnumber,checknumber,correctnumber);
         end
       recgrate(i) = (checknumber/(allnumber));
       correctrate(i) = (correctnumber / checknumber);
        % a{i}=xlsread(str);
         fprintf('识别率是：%.2f,识别正确率是:%.2f;\n',recgrate(i),correctrate(i));
        if(i == k) 
            plot([1:1:k],correctrate,[1:1:k],recgrate);
            title('识别率和正确识别率');
            legend('识别正确率','识别率');
            message=strcat('All Check Finish.');
            msgbox(message,' Check CorrectRate','help');
        end
      end
  %  toc;
 end
 fprintf('With %.2f figure find in size %2.f database, the cost time is:',k,fp_number);
 toc;