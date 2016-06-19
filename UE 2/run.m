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
nTreesPerForest = [1, 5, 10, 20, 30, 40, 70]; %, 100];

% a) Create random forests (TODO: call for >1 element of nTreesPerForest)
[rf, err] = train(images, masks, nTreesPerForest);

% b) Plot error for different numbers of trees
figB = figure();
plot(nTreesPerForest, err, 'rd-');
xlabel('Number of trees per forest');
ylabel('Out-of-bag classification error');
matlab2tikz('figures/oobErr.tex','height', '\figureheight', 'width', '\figurewidth');
%saveas(figB, 'figures/oobErr.png');

% c) Compare importance of individual features
feat = {'grayVal', 'gradX', 'gradY', 'gradMag', ...
        'grayHaar1', 'grayHaar2', 'grayHaar3', 'grayHaar4', 'grayHaar5', ...
        'grayHaar6', 'grayHaar7', 'grayHaar8', 'grayHaar9', 'grayHaar10', ...
        'grayHaar11', 'grayHaar12', 'grayHaar13', 'grayHaar14', 'grayHaar15', ...
        'grayHaar16', 'grayHaar17', 'grayHaar18', 'grayHaar19', 'grayHaar20', ...
        'gradHaar1', 'gradHaar2', 'gradHaar3', 'gradHaar4', 'gradHaar5', ...
        'gradHaar6', 'gradHaar7', 'gradHaar8', 'gradHaar9', 'gradHaar10', ...
        'gradHaar11', 'gradHaar12', 'gradHaar13', 'gradHaar14', 'gradHaar15', ...
        'gradHaar16', 'gradHaar17', 'gradHaar18', 'gradHaar19', 'gradHaar20', ...
        'x', 'y'};
% Indices of selected forests
iRFSelected = [2 4 6];
nTSelected = nTreesPerForest(iRFSelected);

% Create figure of appropriate size (for saving)
scrsz = get(groot,'ScreenSize');
figC = figure('Position',[1 scrsz(4)/3 scrsz(3) scrsz(4)/2]);

% Plot feature importance of selected forests as stacked bar chart 
varImp = [rf{iRFSelected(1)}.OOBPermutedVarDeltaError; ...
          rf{iRFSelected(2)}.OOBPermutedVarDeltaError; ...
          rf{iRFSelected(3)}.OOBPermutedVarDeltaError;];
bar(varImp', 'stacked');

% Optimze layout
xlim([0.5 46.5])
ax = gca;
set(ax,'XTick', 1:46,'XTicklabel',feat, 'FontSize', 7)
rotateXLabels( ax, 45 ) % file from file exchange
xl = xlabel('Features');
yl = ylabel('OOBPermutedVarDeltaError');
set(xl, 'FontSize', 10);
set(yl, 'FontSize', 10);
%print(figC, 'figures/oobVar','-dpng','-r0')
%matlab2tikz('figures/featImp.tex','height', '\figureheight', 'width', '\figurewidth');
legend(strcat(num2str(nTSelected(1)),' trees'), ...
       strcat(num2str(nTSelected(2)),' trees'), ...
       strcat(num2str(nTSelected(3)),' trees'),'Location', 'northwest')
saveas(figC, strcat('figures/oobVarStacked.png'));

%% Task 4: Shape particle filters
% c) optimize the parameter vektor p for every testimage
%%
% info: 1.-5. EV = 97,46 proz. & 1.-4. EV = 96,34 proz. & 1.-9. EV = 99,02
% proz.
[bestP,time] = optimizeP;
%
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
performanceModel = repmat({'k = 4; 3STD region; dist'},[length(performance) 1]);
%save('bestP_4EV_dist_3STD.mat','bestP','performance','performanceModel','time');

% plot according boxplot
figure()
boxplot(performance(:,1),performanceModel);
% boxplot([performance(:,1);performance4S(:,1);performance4L(:,1);performance9L(:,1)], [performanceModel;performanceModel4S;performanceModel4L;performanceModel9L])
ylabel('distance from landmark to nearest mask point [pixel]')
title('segmentation performance of the model')
