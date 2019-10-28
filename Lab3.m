%Kai Jin
%Time: About 4.5hrs
%1.A
x = 1:100000;
c_data = normrnd(12,0.4,[1,100000]);
false_data = [10, 10.3, 2.1, 0, 0, 15.6, 22.3, 12.7];
data = [c_data false_data];
figure()
plot(false_data,1,'*r')
hold on
histogram(c_data)
title('Data with correct and wrong values')
legend('False data')

%We want to get rid of the data which have a very small
%probability(appreance times)for both side which means get rid of x values
%outside 5 sigma start from both right and left side.
pd = fitdist(data','Normal');
prob = normcdf(5);
right_x = icdf(pd,prob);
left_x = icdf(pd,1-prob);

Pos_true = 0;
Pos_false = 0;
Neg_true = 0;
Neg_false = 0;
for i = 1:100008
    if data(i)>left_x&&data(i)<right_x
        if ismember(data(i),false_data)
            Pos_false = Pos_false + 1;
        else
            Pos_true = Pos_true + 1;
        end
    else
        if ismember(data(i),false_data)
            Neg_true = Neg_true + 1;
        else
            Neg_false = Neg_false + 1;
        end
    end
end

table = zeros(2,2);
table(1,1) = Pos_true;
table(1,2) = Pos_false;
table(2,1) = Neg_true;
table(2,2) = Neg_false;
table

%1.B
%There is no omissions. I think if you change the value of sigma you
%choose, the except value of omission will also change. If you choose sigma
%is 1, there will be a 15% chance you get a omission.

%1.C
%Yes, there is comissions. However, we can't avoid it because it is close
%to the mean than some correct data(have a smaller variance).

%2.A
%Assume we get the data of 2D histogram of positional uncertainty. We can
%find the moving distance by formula d=[(dx)^2+(dy)^2]^1/2. If '5 sigma' of
%distand(d) distribution is detection of movement. What is that distance in
%arcseconds(dx and dy)?

%We need get data dx and dy for each pixel in the graph and use the
%formula d=[(dx)^2+(dy)^2]^1/2 to calculate the real movement distance on
%2D graph. After that, we use d to build a normal distribution(I see the
%data is Gaussian distribution random number from codes). Find the
%corresponding x-axis value'5 sigma' which is the minimum distance d to
%detect a motion. Finally, we can find corresponding arcseconds dx and dy.

%3.A
%We observe a moon sized patch on the sky 8 hours per night for 15 days and
%see 6800 cosmic rays, the sun and the moon can block rays and appear as
%holes in the cosmic ray sky. Assume a moon sized patch on the sky we
%normally have a cosmic ray rate of 1 cosmic ray per minute, what is the
%signficance of our moon shadow detection?

%3.B
%Every event in this observation has the same probability and there is no
%clue that they can influence each other. Therefore, the distribution of
%this obeservation should be a poisson distribution.
%1. Caculate the mean of this observation
%2. Build a poisson distribution with "lambda" which is the mean we
%calculate
%3. Calculate the probability beyond 5 sigma in observation distribution
%3. Calculate the corresponding sigma value on observation distribution
%using the probability we calculate in step 2

%3.C
%By formula mean=n*p, n is the number of experience, and p represent the
%probability of a win on any given experience
%Let's assume n is 1 because we do the 15 days observation only once, and p
%is the probability we see a ray during the 15 days
mean = 1*6800/(15*8*60);
ob = makedist('Poisson', 'lambda', mean);
prob = 1-cdf(ob,5);
sigma = norminv(prob)