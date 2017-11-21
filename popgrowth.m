function [timecourse,time] = popgrowth(a,in)
N = 1000*0.99;
pop = @(t,x) [a*x(1)*(1-x(1))];
x = in;
X = x/N;
sol = ode23(pop, [x N],X);
timecourse = (sol.x);
time = length(timecourse);
   
end 