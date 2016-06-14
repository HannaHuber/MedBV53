% *** MedBV UE2 - Group 16 ***
% clear all
close all

addpath TikZ
addpath providedFunctions

%% Init

% Load data
load handdata

% Reshape matrix to dim x nLandmarks x nShapes
%aligned = permute(aligned, [ 2 1 3]);

%% Task 1 : Transform shape model

% Perform PCA
[EShapes, lambdaShapes, meanShapes] = pcaShape(aligned);

% Use first 5 modes
b = sqrt(lambdaShapes(1:5));

% Generate shapes
xOrig = generateShape(EShapes, meanShapes, b, 0, 1, 0, 0);
xLarge = generateShape(EShapes, meanShapes, b, 0, 2, 0, 0);
xSmall = generateShape(EShapes, meanShapes, b, 0, 0.5, 0, 0);
x90 = generateShape(EShapes, meanShapes, b, 90, 1, 0, 0);
x250 = generateShape(EShapes, meanShapes, b, 250, 1, 0, 0);
xLowRight = generateShape(EShapes, meanShapes, b, 0, 1, 50, -20);
xLeft = generateShape(EShapes, meanShapes, b, 0, 1, -50, 0);
xMixed = generateShape(EShapes, meanShapes, b, 45, 1.5, 70, 70);

% Plot scaled shapes
figure()
plot(xOrig(1,:), xOrig(2,:), 'g-');
hold on
plot(xLarge(1,:), xLarge(2,:), 'r.');
plot(xSmall(1,:), xSmall(2,:), 'b--');
%legend('original', 'x2', 'x0.5', 'Location', 'northeastoutside');
hold off
axis equal
%matlab2tikz('figures/trafoS.tex','height', '\figureheight', 'width', '\figurewidth');

% Plot rotated shapes
figure()
plot(xOrig(1,:), xOrig(2,:), 'g-');
hold on
plot(x90(1,:), x90(2,:), 'r.');
plot(x250(1,:), x250(2,:), 'b--');
%legend('original', '90°', '45°', 'Location', 'northeastoutside');
hold off
axis equal
%matlab2tikz('figures/trafoR.tex','height', '\figureheight', 'width', '\figurewidth');

% Plot translated shapes
figure()
plot(xOrig(1,:), xOrig(2,:), 'g-');
hold on
plot(xLowRight(1,:), xLowRight(2,:), 'r.');
plot(xLeft(1,:), xLeft(2,:), 'b--');
%legend('original', 't=(50,-20)', 't=(-50,0)', 'Location', 'northeastoutside');
hold off
axis equal
%matlab2tikz('figures/trafoT.tex','height', '\figureheight', 'width', '\figurewidth');

% Plot mixed shapes
figure()
plot(xOrig(1,:), xOrig(2,:), 'g-');
hold on
plot(xMixed(1,:), xMixed(2,:), 'r.');
%legend('original', 'x1.5, 60°, t=(50,-20)', 'Location', 'northeastoutside');
hold off
axis equal
%matlab2tikz('figures/trafoMix.tex','height', '\figureheight', 'width', '\figurewidth');

%% Task 2: Calculate features
close all

features11 = computeFeatures(images{1,1});
plotFeatures(images{1,1},features11);

%% Task 3: Classification & feature selection
close all

% Init numbers of trees
nTreesPerForest = [1, 5, 10, 20, 30, 40, 70, 100];

% a) Create random forests (TODO: call for >1 element of nTreesPerForest)
[rf, err] = train(images, masks, nTreesPerForest(3));

% TODO: Plot error for different numbers of trees


% c) Compare importance of individual features
figure()
plot(rf{1}.OOBPermutedVarDeltaError);
% TODO: add feature legend
% TODO: solve tikz problem
%matlab2tikz('figures/featImp.tex','height', '\figureheight', 'width', '\figurewidth');


%% Task 4: Shape particle filters
% a) function train and predict
% TODO: train -> laut E-mail mit landmarks und nicht mit aligned!?!?
[rf, err, E, lambda] = train(images(1,1:30), masks, [10], aligned);
predMasks = predictLabel(rf, images(1,31:50));

% c) optimize the parameter vektor p for every testimage
%%
% info: 1.-5. EV = 97,46 proz. & 1.-4. EV = 96,34 proz. & 1.-9. EV = 99,02
% proz.
[bestP,time] = optimizeP;
%%
performance=zeros(64,20);
for i=1:20
param=bestP(:,i);
bestShape = generateShape(EShapes, meanShapes, param(1:end-4), param(end-3), param(end-2), param(end-1), param(end));
figure()
image(predMasks{1,i})
hold on
plot(bestShape(1,:),bestShape(2,:),'r')

% compute segmentation performance
[y,x] = find(masks{1,30+i});
[~,d] = knnsearch([x y],bestShape');
performance(:,i)=d;
end
performance = performance(:);
% performanceModel = repmat({'99% variance within model'},[length(performance) 1]);
figure()
boxplot(performance(:,1), performanceModel)
%xlabel('99% variance within model')
ylabel('distance from landmark to nearest mask point [pixel]')
title('segmentation performance of the model')
%matlab2tikz('figures/box_4EV_dist_gross.tex','height', '\figureheight', 'width', '\figurewidth');

save('bestP_4EV_bool_gross.mat','bestP','performance','performanceModel','time');