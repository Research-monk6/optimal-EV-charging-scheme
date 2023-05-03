% this function for scheduling the EV at charging points based on
%  min waiting time
function [EV_sc2, service_time_sc2, Waiting_time_sc2, Weight_sc2, Total_Power_sc2, Charging_Fees_sc2] = scheduling_2(V,dis,Bsize,Chmood,t,QWT)

Total_Power_sc2= zeros(10,1);
Charging_Fees_sc2=zeros(V,1);
start_id2= 1 ; 
finish_id2=[1 2 3 4 5 6 7 8 9 10]; % Distination 
WT12=QWT;
%% Counter for EVs Number 
 for i=1:V
    
   cari_Id2(i) = i(:);
   SOC(i)=0.3; %SOC is the state of charge
   powre_demand2(i)= (Bsize(i)*(0.95-SOC(i)));
   
%% charging time and charging fees
        for m = Chmood(i) 
         if m == 50
           Ch_time2(i) = ( powre_demand2(i)/50);
           disp('DC charging mood') ;
           if t == 7||t==8||t==9||t==10
           Charging_fees2(i) = powre_demand2(i) * 2.29;
           elseif t == 11||t==12||t==1||t==2
           Charging_fees2(i) = powre_demand2(i) * 4.30;
           elseif t==3||t == 4||t==5||t==6
           Charging_fees2(i) = powre_demand2(i) * 5.83;
           else
               Charging_fees2(i) = 0;
           end
         elseif m == 22 
           Ch_time2(i) = (powre_demand2(i)/22) ;
           disp('AC charging mood') ;   
           if t == 7||t==8||t==9||t==10
           Charging_fees2(i) = powre_demand2(i) * 1.53;
           elseif t == 11||t==12||t==1||t==2
           Charging_fees2(i) = powre_demand2(i) * 2.88;
           elseif t==3||t == 4||t==5||t==6
           Charging_fees2(i) = powre_demand2(i) * 3.92;
           else
           Charging_fees2(i) = 0;
           end  
         end
        end
Charging_Fees_sc2(i)=Charging_Fees_sc2(i)+Charging_fees2(i);
%%  Max_Distance = the maximum distance that EV can be drive  based on the battery SOC 
     %(0.15KWh/km) is the energy consumption of an EV battery per unit of distance
     % Bsize(i) is the total capacity of EV battery
     Max_Distance2(i) =(Bsize(i)* SOC(i)/0.15);

%%  Counter for charging point
    for j=1:10  
        distance2(j) = dis(finish_id2(j),start_id2);              
   %      if   distance_1(j) < 7 
         if  Max_Distance2(i) > distance2(j)
           
%% Travelling time
     traveling_time2(j)=(distance2(j)/60)+0.2 ; %speed is 60km/h
           
%% fuzzy logic
     WT22(j)= WT12(j) ;
     WT32= WT22(:);
     Ch_T2(j)= Ch_time2(i);
     Ch_ev2= Ch_T2(:);
     traveling_ev2 = traveling_time2(:);
     fis = readfis('SDN_ruls3'); % this is senario 2 select charging point with min waiting time
     input2 = [WT32 traveling_ev2 ];
     output2 = evalfis(fis,input2); % fuzzy logic output results

         else 
           disp(['Sorry! EV cannot reach to the station No. = ' num2str(finish_id2(i) )]);   
         end    
    end
     [max_w_cp2 , no_cp2] = max(output2);      
     cp_selected2 = no_cp2;
     weight_to_cp3(i) = max_w_cp2(:)  ;
     fuz_input2 = input2    ;
     tra_t2 =  fuz_input2(no_cp2,2);
     ch_t2 = Ch_ev2(no_cp2,1);
     WT42 = fuz_input2(no_cp2,1);
     WT12(no_cp2) =  Ch_time2(i)+ WT42;
     Total_Power_sc2(no_cp2)= Total_Power_sc2(no_cp2)+ powre_demand2(i);
     cost2(i) = tra_t2 + ch_t2+ WT42  ;

 end

 EV_sc2 = cari_Id2(:);
 service_time_sc2 = cost2(:);
 Waiting_time_sc2 = WT12 ;
 Weight_sc2= weight_to_cp3(:);

end

