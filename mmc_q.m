%sennario 1, all EV request served by the nerest charging point
% n=1;     %[30,50,100]     %number of EV in the charging point M/M/c model
% node = 5;
 function [CP_PRO,cp_WT] = mmc_q(n,node)
switch node
    case 1
      lambda= 8;    %arriving rate ex: number pf EV arriving per time (hour)
      mu= 6;           %service rate ex: number of EV begin to charged
      c=4;     
    case 2
      lambda= 12;
      mu= 5;
      c=3;
    case 3
      lambda= 1;
      mu= 3;
      c=3;
    case 4
      lambda= 5;
      mu= 6;
      c=4;
    case 5
      lambda= 5;
      mu= 4;
      c=3;

    case 6
      lambda= 9;
      mu= 6;
      c=3;
    case 7
      lambda= 4;
      mu= 3;
      c=3;  
    case 8      
      lambda= 3;       
      mu= 8;              
      c=5;
    case 9
      lambda= 15;
      mu= 5;
      c=4;
    case 10
      lambda= 3;
      mu= 9;
      c=5;
    otherwise
      disp('EV has not enough SOC to reach this charging point');       
end

         [pro1 , AWTn] = mmcfindpn(lambda,mu,c,n); %the probability there are n customers at charging point 1        
%        btime=Ch_time(1:35);   % the time needed to process the request from EV
%        [wtime,AWT]= fcfs(n, btime); %creat table for no of EV at charging point 
%        cp_WT = lq;
         cp_WT = AWTn;
         CP_PRO = pro1;
 end