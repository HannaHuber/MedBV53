% *** MedBV UE1 - Group 53 ***

%% Ex. 1 - Covariance
clear all
close all

% Load 2D data
load daten

% Calculate covariance matrices for all data sets
C1 = ourCov(data1);
C2 = ourCov(data2);
C3 = ourCov(data3);
C4 = ourCov(data4);

% % Plot results
% figure()
% % plot(C1,'.');
% plot(data1(1,:),data1(2,:),'.');
% axis equal;
% figure()
% % plot(C2,'.');
% plot(data2(1,:),data2(2,:),'.');
% axis equal;
% figure()
% % plot(C3,'.');
% plot(data3(1,:),data3(2,:),'.');
% axis equal;
% figure()
% % plot(C4,'.');
% plot(data4(1,:),data4(2,:),'.');
% axis equal;

%% Ex. 2 - PCA

[E1,l1] = pca(data1);
plot2DPCA(data1', mean(data1,2)', data1', E1, l1, 1, 0)
[E2,l2] = pca(data2);
plot2DPCA(data2', mean(data2,2)', data2', E2, l2, 1, 0)
[E3,l3] = pca(data3);
plot2DPCA(data3', mean(data3,2)', data3', E3, l3, 1, 0)
[E4,l4] = pca(data4);
plot2DPCA(data4', mean(data4,2)', data4', E4, l4, 1, 0)

%% Ex. 3 - Subspace projection (2D -> 1D)

% Project + reconstruct data3 to main vector
[p3Main, errMain] = project(data3, E3, 1);
plot2DPCA(data3', mean(p3Main, 2)', p3Main', E3, l3, 1, 1)

% Project + reconstruct data3 to second vector
[p3Second, errSecond] = project(data3, E3, 2);
plot2DPCA(data3', mean(p3Second, 2)', p3Second', E3, l3, 1, 1)

%% Ex. 4 - Subspace projection (3D -> 2D)

clear all
close all

% Load 3D data
load daten3d

% 3D project to two main vectors

%% Ex. 5 - Shape Modell

load shapes

[EShapes, lambdaShapes] = pcaShape(aligned);
clear all 
close all

load shapes