% *** MedBV UE1 - Group 16 ***

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

% Plot results
figure()
% plot(C1,'.');
plot(data1(1,:),data1(2,:),'.');
axis equal;
figure()
% plot(C2,'.');
plot(data2(1,:),data2(2,:),'.');
axis equal;
figure()
% plot(C3,'.');
plot(data3(1,:),data3(2,:),'.');
axis equal;
figure()
% plot(C4,'.');
plot(data4(1,:),data4(2,:),'.');
axis equal;

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
[p3Main, ~, errMain] = project(data3, E3, 1);
plot2DPCA(data3', mean(p3Main, 2)', p3Main', E3, l3, 1, 1)

% Project + reconstruct data3 to second vector
[p3Second, ~, errSecond] = project(data3, E3, 2);
plot2DPCA(data3', mean(p3Second, 2)', p3Second', E3, l3, 1, 1)

%% Ex. 4 - 3D data

clear all
close all

% Load 3D data
load daten3d

% PCA
[E3D, l3D] = pca(data);
plot3DPCA(data', mean(data, 2)', E3D, l3D, 1, 0);

% Project to two main vectors
[p, ~, err] = project(data, E3D, [1 2]);
plot3DPCA(data', mean(data, 2)', E3D, l3D, 1, 1);

%% Ex. 5 - Shape Modell
clear all 
close all

load shapes

% a) Calculate the eigenvectors, eigenvalues and the mean
[EShapes, lambdaShapes, meanShapes] = pcaShape(aligned);

% b) Plot the mean and the first 13 modes
nPoints = length(lambdaShapes);
b = repmat(sqrt(lambdaShapes),1,nPoints).*eye(nPoints);
plotShape(EShapes, meanShapes, b)

% c)1. Generate new shape with random b 
% generate random b 
b = randn(nPoints,1).*sqrt(lambdaShapes);

% plot the Shapes
plotShapeK(EShapes, meanShapes, b, [1,3,6,10,20,100]);

% c)2. Generate new shape with random b and percentage of total Variance
% given percentages
percentage = [1, .95, .9, .8];
% allocate k
k = zeros(size(percentage));
% calculate k for the given percentages
for i = 1:length(percentage)
    [EShapesVar, lambdaShapesVar, meanShapesVar, k(i)] = pcaShape(aligned ,percentage(i));
end
% plot the Shapes
plotShapeK(EShapesVar, meanShapesVar, b, k, percentage);
