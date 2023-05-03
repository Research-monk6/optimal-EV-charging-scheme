close all;
clear;
clc;

%%
load dis.mat % Shortest Distance between stations.
%load SOC.mat % Battery states of charge. 
load Bsize.mat % The size of Battery (varies from brand to brand).
load Chmood.mat % The Mood of charging AC or DC.
%load EVID.mat % EVs ID 

%% call the M/M/c function to fine the info. of avilable charging points

for node =1:10
     [CP_PRO,cp_WT] = mmc_q(1,node);
     WT0(node)=cp_WT;
     pro0(node)= CP_PRO;
end
    QWT=WT0(:);
    Qpro1=pro0(:);
    finish_id=[1 2 3 4 5 6 7 8 9 10];
    t=6;  %time request 
%     p1=[2.29;4.30;5.83]; % fast charging pice
%     p2=[1.53;2.88;3.92];
    V=40;  %nomber of EV requests
    
%scenario no.1
  [EV_sc1, service_time_sc1, Waiting_time_sc1, Weight_sc1, Total_Power_sc1, Charging_Fees_sc1] = scheduling_1(V,dis,Bsize,Chmood,QWT);
%scenario no2
  [EV_sc2, service_time_sc2, Waiting_time_sc2, Weight_sc2, Total_Power_sc2, Charging_Fees_sc2] = scheduling_2(V,dis,Bsize,Chmood,t,QWT);
%scenario no3
  [EV_sc3, service_time_sc3, Waiting_time_sc3, Weight_sc3, Total_Power_sc3, Charging_Fees_sc3] = scheduling_3(V,dis,Bsize,Chmood,t,QWT);
   
  total_power= sum(Total_Power_sc3)
  total_profit_sc1= sum(Charging_Fees_sc1)
  total_profit_sc2= sum(Charging_Fees_sc2)
  total_profit_sc3= sum(Charging_Fees_sc3)

  
