%Kai Jin
%Time: About 4.5 hrs

%Input data
h5disp("higgs_100000_pt_1000_1200.h5")
higgs_data = h5read("higgs_100000_pt_1000_1200.h5",'/higgs_100000_pt_1000_1200');

%Data initialization and explaination
%Row 1 - ‘pt'
%The transverse momentum of xy plane, sqrt(Px^2+{y^2)
pt = higgs_data(1,:);
%Row 2 - 'eta'
%Pseudorapidity - a commonly used spatial coordinate describing the angle
%of a particle relative to the beam axis which is the angle between y and z
%axis
eta = higgs_data(2,:);
%Row 3 - 'phi'
%Azimuthal angle - the angle between radius of particle and x axis
phi = higgs_data(3,:);
%Row 4 - 'mass'
%Invariant mass - the portion of the total mass of an object or system of
%objects that is independent of the overall motion of the system. More
%precisely, it is a characteristic of the system's total energy and
%momentum that is the same in all frames of reference related by Lorentz
%transformations. If a center-of-momentum frame exists for the system,
%then the invariant mass of a system is equal to its total mass in that
%"rest frame". In other reference frames, where the system's momentum is
%nonzero, the total mass (a.k.a. relativistic mass) of the system is
%greater than the invariant mass, but the invariant mass remains unchanged
mass = higgs_data(4,:);
%Row 5 - 'ee2'
%2-Point ECF ratio - sum of relative particle radius about 2d plane
%momentum(I am not sure)
ee2 = higgs_data(5,:);
%Row 6 - 'ee3'
%3-Point ECF ratio
ee3 = higgs_data(6,:);
%Row 7 - 'd2'
%3 to 2-Point ratio which is ee3/(ee2)^3
d2 = higgs_data(7,:);
%Row 8 - 'angularity'
angul = higgs_data(8,:);
%Row 9 - 't1'
t1 = higgs_data(9,:);
%Row 10 - 't2'
t2 = higgs_data(10,:);
%Row 11 - 't3'
t3 = higgs_data(11,:);
%Row 12 - 't21'
t21 = higgs_data(12,:);
%Row 13 - 't32'
t32 = higgs_data(13,:);
%Row 14 - 'KtDeltaR'
Kt = higgs_data(14,:);
%I don't understand and can't find explainations of some above variables

figure()
plot(pt,eta,'*')
title('pt vs eta')
%Based on the graph, when pt increase, eta will closer to 0 which particles
%will be closer to y axis

figure()
plot(pt,phi,'*')
title('pt vs phi')
%Based on the graph, it seems phi is independent to pt

figure()
plot(pt,mass,'*')
title('pt vs mass')
%Based on graph, the invariant mass concentrate between 120 and 140 and
%there is no signifacant relationship between pt and mass

figure()
subplot(1,2,1)
plot(pt,ee2,'*')
title('pt vs ee2')
subplot(1,2,2)
plot(pt,ee3,'*')
title('pt vs ee3')
%Based on graph, both ee2 and ee3 will decrease with pt increasing, and ee2
%has a larger decreasing magnitude. However, ee3 can be very close to 0

figure()
plot(pt,d2,'*')
title('pt vs d2')
%Based on graph, it seems a lottle bit discrete comparing to previous
%graphs, and it's hard to determine if there is a relationship between pt
%and d2

figure()
plot(pt,angul,'*')
title('pt vs angularity')
%Based on graph, it is similar to d2 graph, there may be some relationship
%between d2 and angularity

figure()
subplot(3,2,1)
plot(pt,t1,'*')
title('pt vs t1')
subplot(3,2,2)
plot(pt,t2,'*')
title('pt vs t2')
subplot(3,2,3)
plot(pt,t3,'*')
title('pt vs t3')
subplot(3,2,4)
plot(pt,t21,'*')
title('pt vs t21')
subplot(3,2,5)
plot(pt,t32,'*')
title('pt vs t32')
%Based on these graphs, there is no significant relationship between pt and
%the y variables

figure()
plot(pt,Kt,'*')
title('pt vs KtDeltaR')
%Based on graph, it seems similar to d2 and angularity

figure()
plot(d2,angul,'*')
title('d2 vs angualrity')
%The graph looks like a quarter circle and angularity decrease to 0 when d2
%is increasing

figure()
subplot(2,2,1)
plot(t1,t2,'*')
title('t1 vs t2')
subplot(2,2,2)
plot(t1,t3,'*')
title('t1 vs t3')
subplot(2,2,3)
plot(t1,t21,'*')
title('t1 vs t21')
subplot(2,2,4)
plot(t1,t32,'*')
title('t1 vs t32')
%Comparing first three graphs, the separation angle t21 > t3 > t2
%It seems first and forth graph have some kind of inverse relationship

figure()
subplot(2,2,1)
plot(t2,t3,'*')
title('t2 vs t3')
subplot(2,2,2)
plot(t2,t21,'*')
title('t2 vs t21')
subplot(2,2,3)
plot(t2,t32,'*')
title('t2 vs t32')
%For first two graphs, it seems there is a linear realtionship

figure()
subplot(1,2,1)
plot(t3,t21,'*')
title('t3 vs t21')
subplot(1,2,2)
plot(t3,t32,'*')
title('t3 vs t32')
%There may be also a linear relationship between t3 and t21

figure()
plot(t21,t32,'*')
title('t21 vs t32')
%The graph looks like a half circle


%Input data
h5disp("qcd_100000_pt_1000_1200.h5")
qcd_data = h5read("qcd_100000_pt_1000_1200.h5",'/qcd_100000_pt_1000_1200');

%Data initialization
pt = qcd_data(1,:);
eta = qcd_data(2,:);
phi = qcd_data(3,:);
mass = qcd_data(4,:);
ee2 = qcd_data(5,:);
ee3 = qcd_data(6,:);
d2 = qcd_data(7,:);
angul = qcd_data(8,:);
t1 = qcd_data(9,:);
t2 = qcd_data(10,:);
t3 = qcd_data(11,:);
t21 = qcd_data(12,:);
t32 = qcd_data(13,:);
Kt = qcd_data(14,:);

figure()
plot(pt,eta,'*')
title('pt vs eta')
%It seems eta is independent to pt

figure()
plot(pt,phi,'*')
title('pt vs phi')
%Based on the graph, it seems phi is independent to pt

figure()
plot(pt,mass,'*')
title('pt vs mass')
%Based on graph, the invariant mass has a much wider distribution

figure()
subplot(1,2,1)
plot(pt,ee2,'*')
title('pt vs ee2')
subplot(1,2,2)
plot(pt,ee3,'*')
title('pt vs ee3')
%There is no significant relationship between pt and ee2, ee3. ee3 seems
%has a wider separation

figure()
plot(pt,d2,'*')
title('pt vs d2')
%The graph is very uniform

figure()
plot(pt,angul,'*')
title('pt vs angularity')
%It is hard to determine if there is still some relationship between d2 and
%angularity

figure()
subplot(3,2,1)
plot(pt,t1,'*')
title('pt vs t1')
subplot(3,2,2)
plot(pt,t2,'*')
title('pt vs t2')
subplot(3,2,3)
plot(pt,t3,'*')
title('pt vs t3')
subplot(3,2,4)
plot(pt,t21,'*')
title('pt vs t21')
subplot(3,2,5)
plot(pt,t32,'*')
title('pt vs t32')
%It seems very similar to higgs data

figure()
plot(pt,Kt,'*')
title('pt vs KtDeltaR')
%Based on graph, it still seems similar to d2 and angularity

figure()
plot(d2,angul,'*')
title('d2 vs angualrity')
%we can see there is still kind of a inverse relationship here

figure()
subplot(2,2,1)
plot(t1,t2,'*')
title('t1 vs t2')
subplot(2,2,2)
plot(t1,t3,'*')
title('t1 vs t3')
subplot(2,2,3)
plot(t1,t21,'*')
title('t1 vs t21')
subplot(2,2,4)
plot(t1,t32,'*')
title('t1 vs t32')

figure()
subplot(2,2,1)
plot(t2,t3,'*')
title('t2 vs t3')
subplot(2,2,2)
plot(t2,t21,'*')
title('t2 vs t21')
subplot(2,2,3)
plot(t2,t32,'*')
title('t2 vs t32')

figure()
subplot(1,2,1)
plot(t3,t21,'*')
title('t3 vs t21')
subplot(1,2,2)
plot(t3,t32,'*')
title('t3 vs t32')

figure()
plot(t21,t32,'*')
title('t21 vs t32')
%There is not a significant difference from higgs data, however, the data
%points seem a little more concentrated than higgs


%Data initialization
pt = sort(qcd_data(1,:))-sort(higgs_data(1,:));
eta = sort(qcd_data(2,:))-sort(higgs_data(2,:));
phi = sort(qcd_data(3,:))-sort(higgs_data(3,:));
mass = sort(qcd_data(4,:))-sort(higgs_data(4,:));
ee2 = sort(qcd_data(5,:))-sort(higgs_data(5,:));
ee3 = sort(qcd_data(6,:))-sort(higgs_data(6,:));
d2 = sort(qcd_data(7,:))-sort(higgs_data(7,:));
angul = sort(qcd_data(8,:))-sort(higgs_data(8,:));
t1 = sort(qcd_data(9,:))-sort(higgs_data(9,:));
t2 = sort(qcd_data(10,:))-sort(higgs_data(10,:));
t3 = sort(qcd_data(11,:))-sort(higgs_data(11,:));
t21 = sort(qcd_data(12,:))-sort(higgs_data(12,:));
t32 = sort(qcd_data(13,:))-sort(higgs_data(13,:));
Kt = sort(qcd_data(14,:))-sort(higgs_data(14,:));

figure()
plot(pt,eta,'*')
title('pt vs eta')
%It looks like a trail

figure()
plot(pt,phi,'*')
title('pt vs phi')
%Pretty mess

figure()
plot(pt,mass,'*')
title('pt vs mass')
%Maybe it has some relationship to graph1

figure()
subplot(1,2,1)
plot(pt,ee2,'*')
title('pt vs ee2')
subplot(1,2,2)
plot(pt,ee3,'*')
title('pt vs ee3')
%ee2 seems like a exponential function but ee3 not

figure()
plot(pt,d2,'*')
title('pt vs d2')
%Because of the scale, the graph is like a horizontal line

figure()
plot(pt,angul,'*')
title('pt vs angularity')
%It is very similar to graph 3 and 1

figure()
subplot(3,2,1)
plot(pt,t1,'*')
title('pt vs t1')
subplot(3,2,2)
plot(pt,t2,'*')
title('pt vs t2')
subplot(3,2,3)
plot(pt,t3,'*')
title('pt vs t3')
subplot(3,2,4)
plot(pt,t21,'*')
title('pt vs t21')
subplot(3,2,5)
plot(pt,t32,'*')
title('pt vs t32')
%It seems just some strange trails

figure()
plot(pt,Kt,'*')
title('pt vs KtDeltaR')
%Maybe it has relationship to graph 1

figure()
plot(d2,angul,'*')
title('d2 vs angualrity')
%It just looks like a vertical line

figure()
plot(eta,mass,'*')
title('eta vs mass')
%It seems like a exponential function

figure()
plot(eta,angul,'*')
title('eta vs angularity')
%It also seems like a exponential function

figure()
plot(mass,angul,'*')
title('mass vs angularity')
%There may be a linear relationship

figure()
plot(eta,Kt,'*')
title('eta vs KtDeltaR')
%May be a trig function

%It seems phi is a very independent variale and it's hard to determine
%relationships of t1, t2, t3, t21 and t32