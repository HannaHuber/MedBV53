% *** MedBV UE2 - Group 16 ***
clear all
close all

addpath TikZ

%% Init

% Load data
load handdata

% Reshpe matrix to dim x nLandmarks x nShapes
permute(aligned, [ 2 1 3]);

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

%% Task 3: Classification & feature selection
close all

% Init numbers of trees
nTrees = [10, 20, 30, 40, 70, 100];
nForests = length(nTrees);

% Init random forests
rf = cell(1, nForests);
err = zeros(1,nForests);

% % TODO: Discuss if comparison should be done within train() to use same set
% % of background pixel
% for i = 1:nForests
%     
%     % a) Calculate random forest
%     rf{i} = train(images, masks, nTrees(i));
%     
%     % b) Calculate error
%     err(i) = oobError(rf{i});
% 
% end
% 
% % c) Compare importance of individual features
% figure()
% plot(rf{i}.oobPermutedVarDeltaError);
% %matlab2tikz('figures/featImp.tex','height', '\figureheight', 'width', '\figurewidth');


%% Task 4: Shape particle filters
