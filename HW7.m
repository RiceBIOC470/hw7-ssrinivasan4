%HW7
%Sanjana Srinivasan

%GB comments
1a 70 There are two fixed points. One at 0 because a population of 0 people can’t reproduce. Any fluctuation outside of that are stably fixed towards 1 because this is the carrying capacity for that population of people. At that point, the rate of growth is greatly reduced.  Your comment does not accurately discuss why there is a stable point at 1. 
1b. 70 you are correct, ‘a’ does not change the stability of the system. However, it does determine how quickly perturbations in X will correct towards the stable point. 
1c. 100
1d. 90  no axis labels. The growth is not unstable as you say. Also there is no discussion on how the number of fixed points evolves. 
2a. 30 This is the incorrect equation and reflects a model of gene activation and not a toggle switch. Something like this would be accepted : [V/(1+x(2)^4)-x(1); V/(1+x(1)^4)-x(2)];
2b. 95 Graphs are plotted incorrectly because your equations are wrong, but will give credit because its implemented correctly.  However, no axis labels are shown 
2c. 95 Same as 2b. 
overall: 79



% Problem 1: Modeling population growth
% The simplest model for a growing population assumes that each current
% individual has equal likelihood to divide, which yields a differential
% equation dx/dt = a*x where a is the division rate. It is easy to see that
% this will grow exponentially without bound. A simple modification is to
% assume that the growth rate slows done as the population reaches some
% maximum value N so that dx/dt = a*x*(1-x/N). Defining X = x/N, we have 
% dX/dt = a*X*(1-X).  
% Part 1. This equation has two fixed points at 0 and 1. Explain the
% meaning of these two points.

%Reproduction would require a minimum of two individuals, so at 0 or 1,
%the reproductive rate would be fixed.

% Part 2: Evaluate the stability of these fixed points. Does it depend on
% the value of the parameter a? 
%Based on the formula given, at x = 0, you would have - a(0)(1), which
%would result in dx/dt being 0. Similarly, at x = 1, you would have
%a(1)(0), which would also result in dx/dt being 0. Thus, both these points
%are stable at a population growth of 0 regardless of the growth rate.

% Part 3: Write a function that takes two inputs - the initial condition x0
% and the a parameter and integrates the equation forward in time. Make
% your code return two variables - the timecourse of X and the time
% required for the population to reach 99% of its maximum value. 

in=100;
a=20;

[timecourse, time] = popgrowth(a, in);

% Part 4: Another possible model is to consider discrete generations
% instead allowing the population to vary continuously. e.g. X(t+1) = a*
% X(t)*(1-X(t)). Consider this model and vary the a parameter in the range 0
% < a <= 4. For each value of a choose 200 random starting points  0 < x0 < 1 
% and iterate the equation forward to steady state. For each final
% value Xf, plot the point in the plane (a,Xf) so that at the end you will
% have produced a bifucation diagram showing all possible final values of
% Xf at each value of a. Explain your results. 

figure;
for a = 0.1:0.1:4
    for n = 1:200
    in = rand(1,1);
    xf = xo;
    for i = 1:100
        xf = a*xf*(1-xf);
    end
    plot(a,xf,'.');
    hold on;
    end
end
hold off;

%there is an unstable growth in population with increasing values of the
%population growth rate. Thre is an initual steady state followed by a gap
%in the population size followed by an instability in the later values of
%a.

% Problem 2. Genetic toggle switches. 
% Consider a genetic system of two genes A and B in which each gene
% product represses the expression of the other. Make the following
% assumptions: 
% a. Repression is cooperative:  each promotor region of one gene has 4
% binding sites for the other protein and that all of these need to be
% occupied for the gene to be repressed. 
% b. You can ignore the intermediate mRNA production so that the product of
% the synthesis of one gene can be assumed to directly repress the other
% c. the system is prefectly symmetric so that the degradation
% times, binding strengths etc are the same for both genes. 
% d. You can choose time and concentration scales so that all Michaelis
% binding constants and degradation times are equal to 1. 
%
% Part 1. Write down a two equation model (one for each gene product) for
% this system. Your model should have one free parameter corresponding to the
% maximum rate of expression of the gene, call it V. 
%
%setting ku = 0, kb = V, assuming that K = 1 for generality, and setting R
%to A or B

%for gene A
%dx/dt = (V*A^4)/(1+A^4)-B;

%for gene B
%dx/dt = (V*B^4)/(1+B^4)-A;

% Part 2. Write code to integrate your model in time and plot the results for V = 5 for two cases, 
% one in which A0 > B0 and one in which B0 > A0. 
%
%

V= 5;
rhs=@(t,x) [x(2); ((V*x(1)^4)/(1+x(1)^4))-x(2)];

% A = 4, B = 1

sol=ode23(rhs, [0 10], [4; 1]);
figure;
plot(sol.x, sol.y(1,:));
hold on;
plot(sol.x, sol.y(2,:));
hold off;


V= 5;
rhs=@(t,x) [x(2); ((V*x(1)^4)/(1+x(1)^4))-x(2)];

% A = 3, B = 10

sol=ode23(rhs, [0 10], [3; 10]);
figure;
plot(sol.x, sol.y(1,:));
hold on;
plot(sol.x, sol.y(2,:));
hold off;


% Part 3. By any means you want, write code to produce a bifurcation diagram showing all
% fixed points of the system as a function of the V parameter. 

gene = @(x,V) (V*x^4)/(1+x^4)-x;
for V = 0:0.05:5
    gene2 = @(x) gene(x,V);
    for in = 1:0.1:5
        [rt,~,exitflag] = fzero(gene2,in);
        if exitflag == 1
            plot(V,rt,'k.');
            hold on;
        end
    end
end
hold off;

