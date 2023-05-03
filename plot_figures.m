x=1:10; 
x2=1:V;
%wating time 
figure, bar(x,[Waiting_time_sc1,Waiting_time_sc2,Waiting_time_sc3]); 
title('Total Waitting Time at Charging Points');
xlabel('Charging Points') 
ylabel('Time in Hours') 
legend({'random-scenario','FCFS-scenarop with proposed algorithm', 'EV priorty-scenario with proposed algorithm'},'Location','northeast')
%total service time
figure,stairs(x2,service_time_sc1,'b') 
hold on
stairs(x2,service_time_sc2,'g')
hold on
stairs(x2,service_time_sc3,'r')
title('Total Service Time for Each EV')
xlabel('Number of EVS') 
ylabel('Time in hours') 
legend({'random-scenario','FCFS-scenarop with proposed algorithm', 'EV priorty-scenario with proposed algorithm'},'Location','northwest')
hold off

%total poer demand
figure,bar(x,[Total_Power_sc1,Total_Power_sc2,Total_Power_sc3])
title('Total Power Demand Over Charging Points');
xlabel('Charging points') 
ylabel('Time in hours') 
legend({'random-scenario','FCFS-scenarop with proposed algorithm', 'EV priorty-scenario with proposed algorithm'},'Location','northeast')

%weight values
figure, plot(x2,Weight_sc2,'b')
 hold on
 plot(x2,Weight_sc3,'r')
 title('Max Weight for EVs')
 xlabel('Number of EVs') 
 ylabel('Weight value') 
 legend({'FCFS-scenarop with proposed algorithm', 'EV priorty-scenario with proposed algorithm'},'Location','southwest')
 hold off
 
 %charging price
 figure,stem(x2,Charging_Fees_sc1,'r')
 hold on
%  stem(x2,Charging_Fees_sc2,'g')
%  hold on
 stem(x2,Charging_Fees_sc3,'g')
 title('Charging Fees for Each EV')
 xlabel('Number of EVs') 
 ylabel('Charging cost(lei/kw)') 
 legend({'regular charging fees','TOU charging fees'},'Location','northeast')
 hold off
 
 %total charging fees 
  figure,bar(1:2,0)
  hold on
%   bar(3,total_profit_sc2,'g')
%   hold on
  bar(2,total_profit_sc3,'r')
  hold on
  bar(1,total_profit_sc1,'b')
  title('Total EVs Charging Fees')
  xlabel('price amount') 
  ylabel('Price Amount(lei)') 
  legend({'total regular charging fees','total TOU charging fees'},'Location','northwest')
