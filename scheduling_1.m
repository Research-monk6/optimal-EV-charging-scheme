%this function for scheduling the EVs at charging points randomly
function [EV_sc1, service_time_sc1, Waiting_time_sc1, Weight_sc1, Total_Power_sc1, Charging_Fees_sc1] = scheduling_1(V,dis,Bsize,Chmood,QWT)

 Total_Power_sc1= zeros(10,1);
 Charging_Fees_sc1= zeros(V,1);
 finish_id1=[1 2 3 4 5 6 7 8 9 10]; % Distination 
 WT11=QWT;
%% Counter for EVs Number 
 for i=1:V
   start_id1 = randi(10);  
   cari_Id1(i) = i(:);
   SOC(i) =0.3; %SOC is the state of charge
       m = Chmood(i);
    if m == 50
       disp('DC charging mood') ;
    elseif m == 22 
        disp('AC charging mood') ;   
    end
%% ----------------------charging time and charging fees

           powre_demand1(i)= (Bsize(i)*(0.95-SOC(i)));
           Ch_time1(i) = (powre_demand1(i)/m);
           if m == 50 
              Charging_fees1(i) = powre_demand1(i) * 1.95;

           elseif m==22
              Charging_fees1(i) = powre_demand1(i) * 1.45  ; 
           end
      Charging_Fees_sc1(i) = Charging_Fees_sc1(i) +Charging_fees1(i);
     %%  Max_Distance = the maximum distance that EV can be drive  based on the battery SOC 
     %(0.15KWh/km) is the energy consumption of an EV battery per unit of distance
     % Bsize(i) is the total capacity of EV battery
     Max_Distance1(i) =(Bsize(i)* SOC(i)/0.15);
 
%%  Counter for charging point
    for j=1:10  
        distance1(j) = dis(finish_id1(j),start_id1);              
         if   distance1(j) < 70 
          if  Max_Distance1(i) > distance1(j)
           disp(['distance to the station = ' num2str(distance1(j))]); 
%-----------------------
           traveling_time1(j)=(distance1(j)/60)+0.2 ; %calculate the Travelling timespeed with speed = 60km/h   
%% -----------------------fuzzy logic

            WT21(j) = WT11(j) ;
            WT31=WT21(:);
            Ch_T1(j) = Ch_time1(i);
            Ch_ev1 = Ch_T1(:);
            traveling_ev1 = traveling_time1(:);
            fis = readfis('SDN_ruls4'); % this is senario 1 random distribution
            input1 = [WT31 traveling_ev1 ];    %scenario2&3
            output1 = evalfis(fis,input1); % fuzzy logic output results
    
          else 
           disp(['Sorry! EV cannot reach to the station No. = ' num2str(finish_id1(i) )]);   
          end
         end
    end
    fuz_input1 = input1 ;
    [max_w_cp1 , no_cp1] = max(output1);      
    cp_selected1 = no_cp1;
    weight_to_cp1(i) = max_w_cp1(:);  
    tra_t1 =  fuz_input1(no_cp1,2);
    ch_t1 = Ch_ev1(no_cp1,1);
    WT41 = fuz_input1(no_cp1,1);
    WT11(no_cp1) =  Ch_time1(i)+ WT41;
    Total_Power_sc1(no_cp1)= Total_Power_sc1(no_cp1)+ powre_demand1(i);
    cost1(i) = tra_t1 + ch_t1+ WT41;

 end 
 
 EV_sc1 = cari_Id1(:);
 service_time_sc1 = cost1(:);
 Waiting_time_sc1 = WT11 ;
 Weight_sc1= weight_to_cp1(:);
end
 


