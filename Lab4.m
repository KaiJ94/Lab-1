%Kai Jin
%Time use:5hrs(writing codes),more than 10hrs(thinking)

%1
%Input data and initial variables
%Column1-time (in gps seconds)
%Column2-Solar phase (deg) showing the position of sun relative to orbit
%Column3-Earth longitude (deg) giving the position of the spacecraft
%relative to the ground
%Column4-particle counts.
h5disp("gammaray_lab4.h5")
mydata = h5read("gammaray_lab4.h5",'/data');

Time = mydata(:,1);
S_phase = mydata(:,2);
E_long = mydata(:,3);
Counts = mydata(:,4);

figure()
histogram2(S_phase,Counts,'DisplayStyle','tile','ShowEmptyBins','on')
xlabel('Solar phase')
ylabel('Counts')

figure()
histogram2(E_long,Counts,'DisplayStyle','tile','ShowEmptyBins','on')
xlabel('Earth')
ylabel('Counts')

%Based on two graphs above, we can find there is a jump of counts happens
%at Earth longitude about 315 degrees. However, I don't see a signal
%contamination because we can see there is only one peak(yellow part) in
%the distribution and it's pretty consistent. If there is another signal,
%the signal distribution should be more disordered.
figure()
histogram(Counts)
title('Pdf of counts for the whole observation')
%For the background, I will try to build a poisson model because the graph
%above is like a poisson distribution. Each observation is independent and
%it's kind of consistent if we compare counts and solar phase, therefore,
%the probability of each situation in every event should be closed.

%1.B
%Based on the second graph, we can find there is a periodic jump occurs at
%315 Earth longitude degrees and then go back to normal a little bit later.
%It seems like an exponential function.

%1.C
%Because the counts change periodically, we need one periodic dataset to
%figure out function of lumbda.
%Based on graph 2, I assume the start point is approximately 315 degrees of
%Earth longitude
n = 0;
for i = 1:length(E_long)
    if E_long(i) == 315
        n = [n;i];
    end
end
%Based on n values, there are 54000 data points in one period, and I decide
%to use data from row 40501 to 94501 to find function of lambda. Set the
%average interval to 5(I have tested several different numbers and 5 seems
%best)
y = Counts(n(2):n(3));

start = 1;
cont = 1;
x_ave = 0;
y_ave = 0;
x_new = 0;
while cont==1
    y_new = 0;
    for i=0:5
        x_new = x_new+i*0.0067;
        y_new = y_new+y(start+i);
    end
    x_ave = [x_ave;x_new/i];
    y_ave = [y_ave;y_new/i];
    start = start+i;
    if start>=length(y)
        cont = 0;
    end
end
x_ave = x_ave(2:end,1);
y_ave = y_ave(2:end,1);

lambda1 = fit(x_ave,y_ave,'exp1');
lambda2 = fit(x_ave,y_ave,'exp2');
figure()
subplot(1,2,1)
plot(lambda1,x_ave,y_ave)
title('lambda1')
subplot(1,2,2)
plot(lambda2,x_ave,y_ave)
title('lambda2')
%Based on graphs, I decide to use exp2 exponential function which is
%lumbda = 6.175*exp(-0.02082*x) + 5.404*exp(0.0003201*x).
%We know x is Earth longitude, we need find the relationship between x and
%time t.

%Assume we want to estimate probability distribution when Earth longitude
%is 200.
n = 0;
for i = 1:length(mydata)
    if E_long(i) == 200
        n = [n;i];
    end
end
new_counts = 0;
for i=1:length(n)-1
    new_counts = [new_counts;Counts(i+1)];
end

pd = makedist('Poisson','lambda',lambda2(245));
figure()
histogram(new_counts,'Normalization','Probability')
hold on
X = 0:25;
plot(X,pdf(pd,X),'*r')
title('Real counts pd vs estimated pd')
%Based on graph, I think my estimated probability distribution is not bad.

%1.D
pd_sigma = normcdf(5);
%100 millisecond = 0.1s which is 0.0067 difference in Earth longitude
%Assume the initial x is 0
threshold1 = icdf(makedist('Poisson','lambda',lambda2(0)),pd_sigma)
threshold2 = icdf(makedist('Poisson','lambda',lambda2(0.0067)),pd_sigma)
%It seems the threshold doesn't change at all. There is not a significant
%change between 100 ms.
%I may misunderstand this question, however, this is what I thought when I
%saw this question first time.

%2
%Input data and set them to gray scale images
h5disp("images.h5")
myimage = h5read("images.h5",'/imagestack');
image1 = mat2gray(squeeze(myimage(1,:,:)));
image2 = mat2gray(squeeze(myimage(2,:,:)));
image3 = mat2gray(squeeze(myimage(3,:,:)));
image4 = mat2gray(squeeze(myimage(4,:,:)));
image5 = mat2gray(squeeze(myimage(5,:,:)));
image6 = mat2gray(squeeze(myimage(6,:,:)));
image7 = mat2gray(squeeze(myimage(7,:,:)));
image8 = mat2gray(squeeze(myimage(8,:,:)));
image9 = mat2gray(squeeze(myimage(9,:,:)));
image10 = mat2gray(squeeze(myimage(10,:,:)));

figure('Renderer', 'painters', 'Position', [10 10 900 600])
subplot(2,5,1)
imshow(image1)
subplot(2,5,2)
imshow(image2)
subplot(2,5,3)
imshow(image3)
subplot(2,5,4)
imshow(image4)
subplot(2,5,5)
imshow(image5)
subplot(2,5,6)
imshow(image6)
subplot(2,5,7)
imshow(image7)
subplot(2,5,8)
imshow(image8)
subplot(2,5,9)
imshow(image9)
subplot(2,5,10)
imshow(image10)
sgtitle('10 Graphs')

figure()
imshow(image2-image1,'InitialMagnification', 800);
title('Graph of image2 - image1')
%The graph looks kind of uniform, therefore, I don't think there is signal
%contamination

figure()
imshow(image3-image1,'InitialMagnification', 800);
title('Graph of image3 - image1')
figure()
imshow(image4-image1,'InitialMagnification', 800);
title('Graph of image4 - image1')
%Coompare the three background distribution, there is no a significant
%difference. Hence, I think the background is time independent
%Maybe i misunderstand this question. In my opinion, it's hard to say
%consistent, noises from three background is a little different, however, I
%think we should be able to ignore them in general

bg = image2-image1;
figure()
histogram(bg)
xlabel('Brightness')
ylabel('Probability')

%Based on the histogram graph, I think it's a Gaussian distribution
bg_data = bg(:,1);
for i=2:length(bg)
    bg_data = [bg_data;bg(:,i)];
end
pd_bg = fitdist(bg_data, 'Normal');
figure()
x = -0.08:0.001:0.08;
plot(x,pdf(pd_bg,x))
title('Background distribution')
%The shape is very good, however, the y axis difference makes me feel
%nervous to my Q1 distribution. However, I don't think the distribution in
%Q1 is wrong and I really don't have ability to find and correct it.


%2.C
%I want to find the transient star
%If it's like a supernova, its brightness should be high and be
%significantly different from background, thereore, it shoud be over 5
%sigmas
pb = normcdf(5);
cb = icdf(pd_bg,pb);

image1_stars = 0;
for i = 1:length(image1)
   for j = 1:length(image1)
       if image1(i,j)>=cb
           image1_stars = [image1_stars;image1(i,j)];
       end
   end
end

image2_stars = 0;
for i = 1:length(image2)
   for j = 1:length(image2)
       if image2(i,j)>=cb
           image2_stars = [image2_stars;image2(i,j)];
       end
   end
end

image3_stars = 0;
for i = 1:length(image3)
   for j = 1:length(image3)
       if image3(i,j)>=cb
           image3_stars = [image3_stars;image3(i,j)];
       end
   end
end

image4_stars = 0;
for i = 1:length(image4)
   for j = 1:length(image4)
       if image4(i,j)>=cb
           image4_stars = [image4_stars;image4(i,j)];
       end
   end
end

image5_stars = 0;
for i = 1:length(image5)
   for j = 1:length(image5)
       if image5(i,j)>=cb
           image5_stars = [image5_stars;image5(i,j)];
       end
   end
end

image6_stars = 0;
for i = 1:length(image6)
   for j = 1:length(image6)
       if image6(i,j)>=cb
           image6_stars = [image6_stars;image6(i,j)];
       end
   end
end

image7_stars = 0;
for i = 1:length(image7)
   for j = 1:length(image7)
       if image7(i,j)>=cb
           image7_stars = [image7_stars;image7(i,j)];
       end
   end
end

image8_stars = 0;
for i = 1:length(image8)
   for j = 1:length(image8)
       if image8(i,j)>=cb
           image8_stars = [image8_stars;image8(i,j)];
       end
   end
end

image9_stars = 0;
for i = 1:length(image9)
   for j = 1:length(image9)
       if image9(i,j)>=cb
           image9_stars = [image9_stars;image9(i,j)];
       end
   end
end

image10_stars = 0;
for i = 1:length(image10)
   for j = 1:length(image10)
       if image10(i,j)>=cb
           image10_stars = [image10_stars;image10(i,j)];
       end
   end
end

stars = [image1_stars(2:end);image2_stars(2:end);image3_stars(2:end);
         image4_stars(2:end);image5_stars(2:end);image6_stars(2:end);
         image7_stars(2:end);image8_stars(2:end);image9_stars(2:end);
         image10_stars(2:end)];

x = unique(stars);
N = numel(x);
count = zeros(N,1);
for k = 1:N
   count(k) = sum(stars==x(k));
end
disp([ x(:) count ]);

for i = 1:10
    if ismember(x(length(x)-1,1),mat2gray(squeeze(myimage(i,:,:))))
        p = i;
    end
end
p

%Consider unique and brightness, I think the transient star is in graph 2
%which its brightness is 0.9849. The brightness value of 1 seems to be some
%system error I think.

faint = min(stars(:))
%I think the brightness of faintest star is 0.0838

%2.D
%I think we may use different images to build our own background
%diftribution.