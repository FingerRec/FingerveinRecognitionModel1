%�ж�ʶ����
%FRR
%FIR
function checkcorrectrate
global allnumber correctnumber checknumber  correctrate recgrate  choosenum  dividnum  minrecg maxrecg
 tic;
allnumber = 0;%���м���˵�ͼ��
correctnumber =0;%����˵�ͼ����ƥ�䲢����ȷ��
checknumber = 0;%����˵�ͼ����ƥ���
list=dir(['D:\Personal\Desktop\ָ�ƾ���\dataset_617574\617574\FV_samples\','*.bmp']);
k=length(list);
correctrate = zeros(k);%ʶ����ȷ��
recgrate = zeros(k);%ʶ����;
choosenum = 15; %ÿ��ͼ���ظ���
dividnum = 1; %���ݿ����ظ���
minrecg = +inf; % ��ʾ����ͼ��С����
maxrecg = 0; %��ʾ��һ��ƥ���ͼ
 for i=1:k
     str= strcat ('D:\Personal\Desktop\ָ�ƾ���\dataset_617574\617574\FV_samples\', list(i).name);
     image = imread(str);
     image = preprocess(image);
     zeropointnum = sum(image(:)==0);%0�����
     [endp1,fork1,endpoint,forkpoint] = calcu(image);
    minrecg = +inf; % ��ʾ����ͼ��С����
    maxrecg = 0; %��ʾ��һ��ƥ���ͼ
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
            %����ȡ��
            if  ceil(i/choosenum) <= (ceil(maxrecg/dividnum) + 2) && ceil(i/choosenum) >= (ceil(maxrecg/dividnum) - 2);
                correctnumber = correctnumber + 1;
            end     
             fprintf('��%.2f��ͼƬʶ���������Ŀ�ǣ�%.2f,ʶ����Ŀ��:%.2f ��ʶ����ȷ��Ŀ��:%.2f,',i,allnumber,checknumber,correctnumber);
         end
       recgrate(i) = (checknumber/(allnumber));
       correctrate(i) = (correctnumber / checknumber);
        % a{i}=xlsread(str);
         fprintf('ʶ�����ǣ�%.2f,ʶ����ȷ����:%.2f;\n',recgrate(i),correctrate(i));
        if(i == k) 
            plot([1:1:k],correctrate,[1:1:k],recgrate);
            title('ʶ���ʺ���ȷʶ����');
            legend('ʶ����ȷ��','ʶ����');
            message=strcat('All Check Finish.');
            msgbox(message,' Check CorrectRate','help');
        end
      end
  %  toc;
 end
 fprintf('With %.2f figure find in size %2.f database, the cost time is:',k,fp_number);
 toc;