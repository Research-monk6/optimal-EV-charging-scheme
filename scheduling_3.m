% this function for scheduling the EV at charging points based on min
% charging time and min waiting time
function [EV_sc3, service_time_sc3, Waiting_time_sc3, Weight_sc3, Total_Power_sc3, Charging_Fees_sc3] = scheduling_3(V,dis,Bsize,Chmood,t,QWT)

Total_Power_sc3= zeros(10,1);
Charging_Fees_sc3=zeros(V,1);
start_id3= 1; 
finish_id3=[1 2 3 4 5 6 7 8 9 10]; % Distination 
WT13=QWT;
%% Counter for EVs Number 
 for i=1:V

   cari_Id3(i) = i(:);
   SOC =0.3; %SOC is the state of charge

    if Chmood(i) == 50
       disp('DC charging mood') ;
    elseif Chmood(i) == 22 
        disp('AC charging mood') ;   
    end

%% charging time with priority for fast charging 
        for k = 1:50
            m = Chmood(k);
           powre_demand3(k)= (Bsize(k)*(0.95-SOC));
           Ch_time3(k) = (powre_demand3(k)/m);
           if m == 50 
                if t == 7||t==8||t==9||t==10
                 Charging_fees3(k) = powre_demand3(k) * 2.29;
                elseif t == 11||t==12||t==1||t==2
                 Charging_fees3(k) = powre_demand3(k) * 4.30;
                elseif t==3||t == 4||t==5||t==6
                 Charging_fees3(k) = powre_demand3(k) * 5.83;
                else
                 Charging_fees3(i) = 0;
                end
           elseif m==22
                if t == 7||t==8||t==9||t==10
                 Charging_fees3(i) = powre_demand3(i) * 1.53;
                elseif t == 11||t==12||t==1||t==2
                 Charging_fees3(i) = powre_demand3(i) * 2.88;
                elseif t==3||t == 4||t==5||t==6
                 Charging_fees3(i) = powre_demand3(i) * 3.92;
                else
                    Charging_fees3(i) =0;
                end   
           end
        end
    Charging_Fees_sc3(i)=Charging_Fees_sc3(i)+Charging_fees3(i);
    Ch_ev3 = Ch_time3(:);
    ch_ev3 = sort(Ch_ev3) ;   
        
%%  Max_Distance = the maximum distance that EV can be drive  based on the battery SOC 
     %(0.15KWh/km) is the energy consumption of an EV battery per unit of distance
     % Bsize(i) is the total capacity of EV battery
%     Max_Distance(k) =(Bsize(i)* SOC(k)/0.15);

%%  Counter for charging point
    for j=1:10  
        distance3(j) = dis(finish_id3(j),start_id3);              
%         if   distance_1(j) < 7 
%          if  Max_Distance(i) > distance_1(j)
%            disp(['distance to the station = ' num2str(distance_1(j))]);
           
%% Travelling time
     traveling_time3(j)=(distance3(j)/60)+0.2 ; %speed is 60km/h

%% fuzzy logic

      WT23(j) = WT13(j) ;
      WT33=WT23(:);
      Ch_T3(j) = ch_ev3(i);
      Ch_ev3 = Ch_T3(:);
      traveling_ev3 = traveling_time3(:);
      fis = readfis('SDN_ruls5');  % senario 3 give the priority to fast-charging mode  comparing with sc1&sc2 _R5
      input3 = [WT33 traveling_ev3 ];    %scenario2&3
      output3 = evalfis(fis,input3); % fuzzy logic output results
     
%           else 
%            disp(['Sorry! EV cannot reach to the station No. = ' num2str(finish_id(i) )]);   
    end
    fuz_input3 = input3;
    [max_w_cp3 , no_cp3] = max(output3);      
    cp_selected3 = no_cp3;
    weight_to_cp3(i) = max_w_cp3(:); 
    tra_t3 =  fuz_input3(no_cp3,2);
    ch_t3 = Ch_ev3(no_cp3,1);
    WT43 = fuz_input3(no_cp3,1);
    Total_Power_sc3(no_cp3)= Total_Power_sc3(no_cp3)+ powre_demand3(i);
    WT13(no_cp3) =  ch_ev3(i)+ WT43;
    cost3(i) = tra_t3 + ch_t3+ WT43;   

 end

 EV_sc3 = cari_Id3(:);
 service_time_sc3 = cost3(:);
 Waiting_time_sc3 = WT13 ;
 Weight_sc3= weight_to_cp3(:);
end
 

