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
[E,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)
data=data2';
[E,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)
data=data3';
[E,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)
data=data4';
[E,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)

%% Ex. 5 - Shape Modell
clear all 
close all

load shapes