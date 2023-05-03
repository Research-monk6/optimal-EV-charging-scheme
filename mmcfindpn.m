%mmcfindpn(lambda,mu,c,n)
%   This function finds the probability there are n customers and 
%   the average waiting time
%   in the system for an M/M/c queueing system.
function [pro1, AWTn,lq] = mmcfindpn(lambda,mu,c,n)
p = lambda/(mu*c);
pc = lambda/mu;

%lambda is avarge request per time 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This function finds the probability all machines are working
%   for an M/M/c queueing system.
    firstsum = 0;
        for i = 0:c-1
             term = (pc^i)/(factorial(i));
             firstsum = firstsum + term;
        end
    total = firstsum + ((pc)^c)/(factorial(c)*(1-p));
    p0 = total^-1;
    pr0 = p0;  %probability all machines are working
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if n == 0
    pn = pr0;
end
if n >= 1
    if n < c
        pn = (pc^n)/factorial(n)*pr0;
    end
end
if n >= c
    pn = (c^c)/factorial(c)*p0*p^n;
end

pro1 = pn;
lq = ((pc)^c)/factorial(c)*p0*p/((1-p)^2); %the average queue size
AWTn = lq/lambda; %the average waiting time
