% A little statistics
%1.B
%I try three different x values -- 1, 2 and 3 to find probability from -Inf
%to x which the mean of normal distribution is 0
pb = {normcdf(1,0,1), normcdf(2,0,1), normcdf(3,0,1)};
%1.C
%I try to make the inverse probability match x values 1, 2 and 5
sigma = {norminv(0.84134), norminv(0.97725), norminv(0.9999997134)};
%1.D
%We set the mean at 0, therefore, if a posibility is less than 0.5 its
%reverse sigma value will be less than 0

%2.A
x = linspace(0,10,100000);
logN = makedist("Lognormal",'mu',0.5, 'sigma',0.8);
%2.B
subplot()
plot(x,pdf(logN,x),"LineWidth",4);

%3.A
% My hypothetical measurement is at x=6 of background distribution
%3.B
%The signal I found always lay on the region x>6 of background
%distribution. What's the probability I can find the signal from the 
%background?
%3.C
%pb = 1 - integral(logN, -Inf, 6)
%3.D
pb2 = 1 - cdf(logN, 6);
%3.E
sigma2 = norminv(1 - pb2);

%4
%For 4
pb3_1 = 1 - cdf(logN, 4);
sigma3_1 = norminv(1 - pb3_1);
%For 5
pb3_2 = 1 - cdf(logN, 5);
sigma3_2 = norminv(1 - pb3_2);
%For 7
pb3_3 = 1 - cdf(logN, 7);
sigma3_3 = norminv(1 - pb3_3);
%It shows that the probability of right side of lognormal distribution
%has a reverse relationship to sigma

% Non-continuous distributions
%1.A
x = 0:10;
poisson = makedist("Poisson", 'lambda',3); 
%1.B
subplot(2,2,1)
stairs(x,pdf(poisson,x),"LineWidth",4);

subplot(2,2,2)
stairs(x-0.5,pdf(poisson,x),"LineWidth",3);

subplot(2,2,3)
stairs(x-5,pdf(poisson,x),"LineWidth",1);

subplot(2,2,4)
stairs(x-10,pdf(poisson,x),"LineWidth",3);
%The first parameter indicates the start point of x-axis
%The second parameter is the distribution data
%The third parameter add control to line width in the graph and last
%parameter decides the line width
%1.C
%Find the probability between x=5 and x=7
pb4 = cdf(poisson, 7) - cdf(poisson, 5);
%1.D
%The probability of distribuyion is the area under its graph, we can only
%choose the integer x value, therefore, the area(probability) is also
%discrete. This is harder for us to estimate the value outside of current
%data and find trnd line of data set.
%1.E
%The mean value in poisson distribution is the expect value of random event
%in a unit length, it doesn't mean this situation must happen.
