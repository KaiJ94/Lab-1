%Kai Jin

%1
%Rolling sevens is more probable because the combination for one and one
%is only 1, however, there are more than one combination for seven.
%(1/36)/(6/36) = 1/6

%2
%P(0)=0
%P(1)=P(1)*P(0)=0
%P(2)=P(1)*P(1)=1/36
%P(3)=P(1)*P(2)+P(2)*P(1)=2/36=1/18
%P(4)=P(1)*P(3)+P(2)*P(2)+P(3)*P(1)=3/36=1/12
%P(5)=P(1)*P(4)+P(2)*P(3)+P(3)*p(2)+P(4)*P(1)=4/36=1/9
%P(6)=P(1)*P(5)+P(2)*P(4)+P(3)*P(3)+P(4)*P(2)+P(5)*P(1)=5/36
%P(7)=P(1)*P(6)+P(2)*P(5)+P(3)*P(4)+P(4)*P(3)+P(5)*P(2)+P(6)*P(1)=6/36=1/6
%P(8)=P(2)*P(6)+P(3)*P(5)+P(4)*P(4)+P(5)*P(3)+P(6)*P(2)=5/36
%P(9)=P(3)*P(6)+P(4)*P(5)+P(5)*P(4)+P(6)*P(3)=4/36=1/9
%P(10)=P(4)*P(6)+P(5)*P(5)+P(6)*P(4)=3/36=1/12
%P(11)=P(5)*P(6)+P(6)*P(5)=2/36=1/18
%P(12)=P(6)*P(6)=1/36
 
%Calculate probability for every combination of two dices
size = 1;
 result = zeros(36,1);
 for x = 1:12
     for c = 1:6
         if (x-c)<=0
         else if (x-c)>6
             else
                 result(size,1) = x;
                 size = size + 1;
             end
         end
     end
 end
 figure()
 histogram(result,'Normalization','Probability')
 xlabel('Sum of two dices')
 ylabel('Probability')

%3
  result2 = zeros(1,11);
  for x = 2:12
      for c = 1:6
          if (x-c)<=0
          else if (x-c)>6
              else
                  result2(1,x-1) = result2(1,x-1) + 1/36;
              end
          end
      end
  end

ave = 0;
for c = 1:length(result2)
    ave = ave+(c+1)*result2(1,c);
end

variance = 0;
for c = 1:length(result2)
    variance = variance+sqrt(((c+1)-ave)^2*result2(1,c));
end

%4
dice10 = zeros(1,10);
for c = 1:10
    dice1 = randi(6,1);
    dice2 = randi(6,1);
    total = dice1+dice2;
    dice10(1,c) = total*result2(1,total-1);
end

 figure()
 subplot(1,2,1)
 histogram(dice10,'Normalization','Probability')
 xlabel('Average')
 ylabel('Ptobability')
 
 subplot(1,2,2)
 histogram(dice10)
 set(gca,'YScale','log')
 xlabel('Average')
 ylabel('Log of Probability')

%I run several times simulation. Based on the graph, it looks like Gaussian
%distribution sometimes, however, sometimes it is not.

%5
x = linspace(-10,10,1000);
std0 = 5;
mean0 = 3;
%get 1000 random num from Gaussian distribution which mean is 3 and std is
%5
gaus1_data = sort(std0.*randn(1000,1) + mean0);
std0 = 2;
mean0 = 0;
%get 1000 random num from Gaussian distribution which mean is 0 and std is
%2
gaus2_data = sort(std0.*randn(1000,1) + mean0);
%get average of two distributions above
ave_data = sort((gaus1_data+gaus2_data)*0.5);
%build these three distribution
gaus1 = fitdist(gaus1_data, 'Normal');
gaus2 = fitdist(gaus2_data, 'Normal');
ave = fitdist(ave_data, 'normal');

figure()
subplot(1,3,1)
plot(x,pdf(gaus1,x),"LineWidth",4)
title('Gaussian distribution 1')
subplot(1,3,2)
plot(x,pdf(gaus2,x),"LineWidth",4)
title('Gaussian distribution 2')
subplot(1,3,3)
plot(x,pdf(ave,x),"LineWidth",4)
title('Ave of distribution 1 and 2')

stats1 = [mean(gaus1_data) std(gaus1_data) var(gaus1_data)];
stats2 = [mean(gaus2_data) std(gaus2_data) var(gaus2_data)];
stats3 = [mean(ave_data) std(ave_data) var(ave_data)];

%Based on the graphs and calculations, we can find that the average of two
%Gaussian distributions is also a Gaussian distribution, and its mean and
%std are very closed to the average of two original Gaussian distributions. Therefore,
%if we get a Gaussian distribution data set from lab, we may also consider
%it can be combined by some other sub Gaussian distributions
