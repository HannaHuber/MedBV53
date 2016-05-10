% *** MedBV UE1 - Group 53 ***

%% Ex. 1 - Covariance
clear all
close all

% Load data
load daten

% Calculate covariance matrices for all data sets
C1 = ourCov(data1);
C2 = ourCov(data2);
C3 = ourCov(data3);
C4 = ourCov(data4);

% Plot results
figure()
plot(C1);
axis equal;
figure()
plot(C2);
axis equal;
figure()
plot(C3);
axis equal;
figure()
plot(C4);
axis equal;

%% Ex. 2 - PCA
clear all
close all

load daten

data=data1';
[E1,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)
data=data2';
[E2,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)
data=data3';
[E3,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)
data=data4';
[E4,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)

%% Ex. 3 - Subspace projection

% Project data3 to main vector
p3Main = project(data3, E3(:,1));
plot2DPCA(data3, mean(data3, 2), p3Main, E, l, 1, 0)

% 2D project to second vector
p3Second = project(data3, E3(:,2));

% 3D project to two main vectors
%% Ex. 5 - Shape Modell
clear all 
close all

load shapes