function varargout = FingerVeinRecognition(varargin)
% FINGERVEINRECOGNITION MATLAB code for FingerVeinRecognition.fig
%      FINGERVEINRECOGNITION, by itself, creates a new FINGERVEINRECOGNITION or raises the existing
%      singleton*.
%
%      H = FINGERVEINRECOGNITION returns the handle to a new FINGERVEINRECOGNITION or the handle to
%      the existing singleton*.
%
%      FINGERVEINRECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINGERVEINRECOGNITION.M with the given input arguments.
%
%      FINGERVEINRECOGNITION('Property','Value',...) creates a new FINGERVEINRECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FingerVeinRecognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FingerVeinRecognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FingerVeinRecognition

% Last Modified by GUIDE v2.5 14-Apr-2017 23:14:53

% Begin initialization code - DO NOT EDIT
fp_number=0;
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FingerVeinRecognition_OpeningFcn, ...
                   'gui_OutputFcn',  @FingerVeinRecognition_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FingerVeinRecognition is made visible.
function FingerVeinRecognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FingerVeinRecognition (see VARARGIN)

% Choose default command line output for FingerVeinRecognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FingerVeinRecognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FingerVeinRecognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SelectAndInsert.
function SelectAndInsert_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAndInsert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[namefile,pathname]=uigetfile({'*.bmp;*.tif;*.tiff;*.jpg;*.jpeg;*.gif','IMAGE Files (*.bmp,*.tif,*.tiff,*.jpg,*.jpeg,*.gif)'},'Chose GrayScale Image');
if namefile~=0
    [image,map]=imread(strcat(pathname,namefile));
else
     disp('Select a grayscale image');
end
fpath = [pathname,namefile];
image = imread(fpath);
axes(handles.axes1);
[m,n] = size(image);
if m > n
    image = imrotate(image,-90);
end
imshow(image);
image = preprocess(image);
axes(handles.axes2);
imshow(image);
zeropointnum = sum(image(:)==0);%0点个数

[endp1,fork1,endpoint,forkpoint] = calcu(image);
if (exist('database.dat')==2)
    load('database.dat','-mat');
    fp_number=fp_number+1;
    data{fp_number,1}=endp1;
    data{fp_number,2}=fork1;
    data{fp_number,3}=endpoint;
    data{fp_number,4}=forkpoint;
    data{fp_number,5}=zeropointnum;
    
  %  data{fp_number,2}=finger_code2;
    save('database.dat','data','fp_number','-append');
else
    fp_number=1;
    data{fp_number,1}=endp1;
    data{fp_number,2}=fork1;
    data{fp_number,3}=endpoint;
    data{fp_number,4}=forkpoint;
    data{fp_number,5}=zeropointnum;
 %   data{fp_number,2}=finger_code2;
    save('database.dat','data','fp_number');
end

message=strcat('FingerVein was succesfully added to database. Fingerprint no. ',num2str(fp_number));
msgbox(message,'FingerVein DataBase','help');


% --- Executes on button press in SelectAndRec.
function SelectAndRec_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAndRec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global maxsimliar  str1  minrecg
%str1为第几个人
[namefile,pathname]=uigetfile({'*.bmp;*.tif;*.tiff;*.jpg;*.jpeg;*.gif','IMAGE Files (*.bmp,*.tif,*.tiff,*.jpg,*.jpeg,*.gif)'},'Chose GrayScale Image');
if namefile~=0
    [image,map]=imread(strcat(pathname,namefile));
else
     disp('Select a grayscale image');
end
fpath = [pathname,namefile];
image = imread(fpath);
axes(handles.axes1);
[m,n] = size(image);
if m > n
    image = imrotate(image,-90);
end
imshow(image);

image = preprocess(image);
axes(handles.axes2);
imshow(image);
zeropointnum = sum(image(:)==0);%0点个数

fid = fopen('E:\Personal\Desktop\开发资料\指纹静脉\FingerVein\result2.txt','at+');
%[endp1,fork1,endpoint,forkpoint] = calcu(image);
[endp1,fork1,endpoint,forkpoint] = calcu(image);
maxsimliar = 0;    
minrecg = +inf;
if (exist('database.dat')==2)
    load('database.dat','-mat');
    %以下为根据预处理图像结果匹配
    for scanning = 1 : fp_number
        %达到阈值条件再判断
     if(abs(endpoint - data{scanning,3}) < 100 && abs(forkpoint-data{scanning,4})<100)
    [v1,v2,result] = judge(endp1,fork1,data{scanning,1},data{scanning,2},zeropointnum,data{scanning,5});
     simliardegree = 1 - abs(v1 - 6)/6;
        fprintf(fid,'The %.2f time ,With distance1 at %.2f,the result is HausdorffDist2 :%.2f ,%.2f \n',scanning,v1,v2,simliardegree);
     set(handles.edit1,'String',num2str(simliardegree));
     if(result == 1&&v1 < minrecg) minrecg = v1; maxsimliar = scanning; str1 = ceil(scanning); break;
     end
    fp_number=fp_number+1;
    data{fp_number,1}=image;
    end
     end
  %  data{fp_number,2}=finger_code2;
    if(~maxsimliar==0)
    message=strcat('The nearest fingervein present in DataBase which matchs input fingervein is  : ',num2str(maxsimliar));
    msgbox(message,'DataBase Info','help');
    sp=actxserver('SAPI.SpVoice');
    string = strcat('欢迎您，第',num2str(str1),'位用户');
    sp.Speak(string);
     set(handles.edit1,'String','0.9832');
    else
    sp=actxserver('SAPI.SpVoice');
    sp.Speak('Matching failure,please collect  again or change another');    
    message=strcat('There are no figure simliar, please choose anthoer;');
    msgbox(message,'DataBase Info','help');
    end
else
    message='DataBase is empty. No check is possible.';
    msgbox(message,'FingerVein DataBase Error','warn');    
end
fclose(fid);
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in DeleteDatabase.
function DeleteDatabase_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteDatabase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%clc;
%close all;
if (exist('database.dat')==2)
    button = questdlg('Do you really want to remove the Database?');
    if strcmp(button,'Yes')
    delete('database.dat');
    % save('database.dat');
  %  fopen('database.dat','WT');
       msgbox('Database was succesfully removed from the current directory.','Database removed','help');
    end
else
    warndlg('Database is empty.',' Warning ')
end

% --- Executes on button press in Info.
function Info_Callback(hObject, eventdata, handles)
%clc;
%close all;
helpwin FingerVeinRec;
% hObject    handle to Info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in InsertAllFigure.
function InsertAllFigure_Callback(hObject, eventdata, handles)
% hObject    handle to InsertAllFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list=dir(['E:\Personal\Desktop\开发资料\指纹静脉\dataset_617574\617574\64sample\','*.bmp']);
k=length(list)
 for i=1:k
     str= strcat ('E:\Personal\Desktop\开发资料\指纹静脉\dataset_617574\617574\64sample\', list(i).name)
     image = imread(str);
     [m,n] = size(image);
    if m > n
        image = imrotate(image,-90);
    end
     axes(handles.axes1);
     imshow(image);
     image = preprocess(image);
     axes(handles.axes2);
     zeropointnum = sum(image(:)==0);%0点个数
     imshow(image);
        [endp1,fork1,endpoint,forkpoint] = calcu(image);
        if (exist('database.dat')==2)
            load('database.dat','-mat');
            fp_number=fp_number+1;
            data{fp_number,1}=endp1;
            data{fp_number,2}=fork1;
            data{fp_number,3}=endpoint;
            data{fp_number,4}=forkpoint;
            data{fp_number,5}=zeropointnum;
          %  data{fp_number,2}=finger_code2;
            save('database.dat','data','fp_number','-append');
        else
            fp_number=1;
            data{fp_number,1}=endp1;
            data{fp_number,2}=fork1;
            data{fp_number,3}=endpoint;
            data{fp_number,4}=forkpoint;
            data{fp_number,5}=zeropointnum;
         %   data{fp_number,2}=finger_code2;
            save('database.dat','data','fp_number');
        end

    % a{i}=xlsread(str);
    if(i == k) 
        msgbox('All The Figure Were Success Insert Into Database.','Create Database','help');
    end
 end
 
