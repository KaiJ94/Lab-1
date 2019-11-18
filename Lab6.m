%Kai Jin
%Time:5 hrs

%Problem 1
%Build the initial background
x = linspace(0,200);
bg = makedist('Poisson','lambda',100);
%Get 1000 random poisson distribution numbers
bg_data = poissrnd(100,[1000,1]);

%Find 5 sigma threshold value
pb_sigma = normcdf(5);
threshold = icdf(bg,pb_sigma)

%Problem 2
%Assume the signal strength is 8 sigma value
%If I choose sigma value larger than 8, the probability will reach 1(I
%think there may be something wrong but I don't know how to fix it)
signal_value = icdf(bg,normcdf(8));

figure()
histogram(bg_data)
title('Background Distribution')

%Assume inserting 300 signals randomly to background
n = 300;
signal = zeros(1,length(bg_data));
signal(randi(numel(signal),[1,n])) = signal_value;
obs_signal = bg_data.' + signal;

figure()
histogram(obs_signal)
title('Observed Signal Distribution')

%2.A
%Based on the graph, it seems there are two parts in this graph, one on the
%left is the background distribution, and the right one describes inserting
%signals+background.
%2.B
%Based on graphs, the observed signals(right peak part) are much higher
%than its origin, however, if we cancel the background influence, the mean
%of observed signal is very closed to 190.It has signal biased because I
%think signal strength is a little smalled in the graph I think, and of
%course, it looks not really symmetric because its background is poisson
%distribution which is not required to be symmetric


%Problem 3
%I choose use 5 sigma values
%Build a new 2D background data with 1000x1000 array(Tbh, I don't
%understand why we must create a 2d background data array, I just copy the
%code from lecture notes and make a minor change
bg_data = poissrnd(100,[1000,1000]);
signalstrength = linspace(0,icdf(bg,normcdf(5)),1000);
[scratch, signal] = meshgrid(signalstrength);
obs_signal = bg_data + signal;
figure()
h1 = histogram2(obs_signal,signal,100,'DisplayStyle','tile','ShowEmptyBins','on');ylabel("Injected signal")
xlabel("observed signal")
title("Confidence intervals with 0-5 sigma signals")

%Use signal value in P2
signalstrength = linspace(0,signal_value,1000);
[scratch, signal] = meshgrid(signalstrength);
obs_signal = bg_data + signal;
figure()
h2 = histogram2(obs_signal,signal,100,'DisplayStyle','tile','ShowEmptyBins','on');
ylabel("Injected signal")
xlabel("observed signal")
title("Confidence intervals 0-8 sigma signals")
%3.A&B
%These graphs show relationship of inserting signals and the its possible
%location range. By graphs, we can see graph 1 and 2 have the same slope,
%therefore, 5 and 8 sigma signals have the same slope graph

%3.C
%I choose 0-5 sigma 2D histogram graph
observation = 50;
injected = signal(abs(obs_signal - observation)<0.05);
figure()
histogram(injected)
title(["Observed signal = ", num2str(observation)])
xlabel("Injected signal")

observation = 170;
injected = signal(abs(obs_signal - observation)<0.05);
figure()
histogram(injected)
title(["Observed signal = ", num2str(observation)])
xlabel("Injected signal")
%Comparing these two graphs, we can know the graph shows the probability
%of insering signal for different signal values. There is no inserting
%signal in graph1, so it's just a line with 0 probability

%3.D
injected_pd = fitdist(injected,'Poisson');
mean = injected_pd.ParameterValues
%pb of 1 std is 0.682689492137086
left_bound = icdf(injected_pd,(1/2)*(1-0.682689492137086))
right_bound = icdf(injected_pd,1-(1/2)*(1-0.682689492137086))

%3.E
%We can assume mean is 70, and we can find the left bound and right are not
%symmetric because the distribution is not symmetric by the graph


%Problem 4
%Choose 1 sigma signal strength
observation = icdf(bg,normcdf(1));
injected = signal(abs(obs_signal - observation)<0.05);
figure()
histogram(injected)
title(["Observed signal = ", num2str(observation)])
xlabel("Injected signal")

%2.B
%The true signal pdf() extend to zero means the observation is a little far
%to inserting signals

%3.C
%I assume 5 sigma is the key value to detect a signal
observation = icdf(bg,normcdf(5));
injected = signal(abs(obs_signal - observation)<0.05);
figure()
histogram(injected)
title(["Observed signal = ", num2str(observation)])
xlabel("Injected signal")

injected_pd = fitdist(injected,'Poisson');
right_bound = icdf(injected_pd,0.95)