function [hd,hd2,result] = judge(endp1,fork1,endp2,fork2,a,b)
global thresoldhd thresoldhd2 thresoldsub thresoldmin 
%[endp1,fork1,endpoint,forkpoint],[endp2,fork2,endpoint2,forkpoint2]
%endp1=pointseta(1);
%fork1=pointseta(2);
%fork1
%endpoint=pointseta(2);
%forkpoint=pointseta(3);

%%endp2=pointsetb(1);
%fork2=pointsetb(2);
%endpoint2=pointsetb(2);
%forkpoint2=pointsetb(3);
hd = HausdorffDist2(endp1,endp2);
hd2 = HausdorffDist2(fork1,fork2);

%if abs(endpoint - endpoint2) <= 130 &&  abs(forkpoint - forkpoint2) <= 3
thresoldmin = 5.4;
thresoldhd =5.67;
thresoldhd2 =5.80;
thresoldsub =60;

if(hd<thresoldhd  && hd2 < thresoldhd2 && abs(a - b)<thresoldsub)
    result = 1;
else result = 0;
end
if((hd<thresoldmin)||hd2<thresoldmin) 
    result =1; 
end
