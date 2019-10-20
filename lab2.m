%Kai Jin
%1.A
%Build the first day poisson distribution at mean is 3
x = 0:10;
poisson1 = poisspdf(x,3);
figure()
subplot(2,2,1)
stairs(x,poisson1,"LineWidth",4);
title('1 Day data')
 
x = 0:20;
poisson2 = conv(poisson1,poisson1);
subplot(2,2,2)
stairs(x,poisson2,"LineWidth",4);
title('2 Days data')
 
x = 0:30;
poisson3 = conv(poisson2,poisson1);
subplot(2,2,3)
stairs(x,poisson3,"LineWidth",4);
title('3 Days data')
 
x = 0:40;
poisson4 = conv(poisson3,poisson1);
subplot(2,2,4)
stairs(x,poisson4,"LineWidth",4);
title('4 Days data')
 
%1.B
x = 0:50;
poisson5 = conv(poisson4,poisson1);
figure()
stairs(x,poisson5,"LineWidth",4);
title('5 Days data')
%Because the data from each day is poisson distribution, therefore, combine
%them together will produce a poisson distribution with new mean, and it
%will become more and more like Gaussian distrbution by central limit
%theorem.
%In other words, new distribution will show all possible combine and its
%probability of two old poisson distributions. Because two old distributions
%are poisson which x is discrete, therefore, the new distribution must be
%similar to them.

%2.A
x = 0:2/200:2;
pd = raylpdf(x,0.5);

figure()
subplot(2,2,1)
plot(x,pd)
title('Original data')

x = 0:0.01:4;
pd1 = conv(pd,pd);
subplot(2,2,2)
plot(x,pd1)
title('1 Average interval')

x = 0:0.01:6;
pd2 = conv(pd1,pd);
subplot(2,2,3)
plot(x,pd2)
title('2 Average interval')

x = 0:0.01:8;
pd3 = conv(pd2,pd);
subplot(2,2,4)
plot(x,pd3)
title('3 Average interval')

%The distribution will become more and more like Gaussian distribution as
%the number of convolution increase. When you add more and more
%distribution, it will produce a single new average mean with a high peak
%distribution. If the peak goes more and more high, the distribution will
%be more and more like a Gaussian distribution.

%2.B
pd4 = conv(pd3,pd);
x = 0:0.01:(length(pd4)-1)*0.01;
figure()
subplot(1,2,1)
plot(x,pd4)
title('4 Average interval)')
subplot(1,2,2)
plot(x,pd4)
set(gca,'YScale','log')
title('Log of Y scale')

pd5 = conv(pd4,pd);
x = 0:0.01:(length(pd5)-1)*0.01;
figure()
subplot(1,2,1)
plot(x,pd5)
title('5 Average interval)')
subplot(1,2,2)
plot(x,pd5)
set(gca,'YScale','log')
title('Log of Y scale')

pd6 = conv(pd5,pd);
x = 0:0.01:(length(pd6)-1)*0.01;
figure()
subplot(1,2,1)
plot(x,pd6)
title('6 Average interval)')
subplot(1,2,2)
plot(x,pd6)
set(gca,'YScale','log')
title('Log of Y scale')

pd7 = conv(pd6,pd);
x = 0:0.01:(length(pd7)-1)*0.01;
figure()
subplot(1,2,1)
plot(x,pd7)
title('7 Average interval)')
subplot(1,2,2)
plot(x,pd7)
set(gca,'YScale','log')
title('Log of Y scale')
%The graph looks pretty similar to Gaussian distribution after 3
%convolution. The shape of its logY graph doesn't change significantly
%after 3 convolution. Therefore, I would say it approaches a Gaussian
%distribution after 3 convolution(4 intervals).

%3.A
%Assume X(width) is 5, and Y is 27.875, assume we want signals' strength is
%larger than Y
X = 5;
Y = 27.875;
%The background distribution graph
bg = makedist('Normal','sigma',X);
x = -30:30;
figure()
plot(x,pdf(bg,x))
title('Background')

%Assume all signal strength is larger than Y is the signal we want
s_pd = 1-cdf(bg,Y)
sigma = norminv(1-s_pd)
%sigma = 5.5750>5, therefore, you can claim a discovery

%3.B
%For one pixel, the distribution is background in last question, Therefore,
%pdf of 10k pixels should be 10k*background pdf.
N = 10000;
figure()
plot(x,N*pdf(bg,x))
title('Background with 10k pixels')

%3.C
s_pd2 = N*s_pd;
sigma2 = norminv(1-s_pd2)

%4.A
pd_5 = normcdf(5);
signal = icdf(bg,1-pd_5)

%4.B
signal2 = icdf(bg,1-pd_5/N)

%4.C
%Signal should be larger than signal2 value which is 18.5951
%When the factor is large, you need a very strong signal to be observed,
%therefore, the sensitivity penalty is not important because the amount it
%influences is smaller to observed signal strength.

%4.D
%First, the probability for 5 sigmal of a standard normal distribution will
%not change, the pd_5 is constant. The critical part is the probability
%with factor times higher.
%If we change 3 order of fator number
f = 3;
guess = (signal2-signal)^f
%My guess is there will be a pretty huge change.

%Extre
%I think the sensitivity penalty will decrease if trials number goes up. We
%need the event become more significant when trails number is big.
%Therefore, the several mistakes caused by sensitivity problem will be less
%significant comparing to the number obsevation we need to claim discovery
%of this event.