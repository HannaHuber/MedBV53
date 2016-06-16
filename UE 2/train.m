function [ rf, err, E, lambda, meanS ] = train( images, masks, nTreesPerForest, aligned )
%TRAIN trains random forest 
%   Input: images           ...    1 x nImages cell of training data images   
%          masks            ...    1 x nImages cell of corrsponding labels
%          nTreesPerFOrest  ...    1 x nForests array containing number of trees in each random forest
%          aligned          ...    nLandmarks x nDimensions x nShapes tensor containing the aligned images
%   Output: rf              ...    1 x nForests cell of random forest objects (instance of Matlab's TreeBagger class)
%           err             ...    1 x nForests array containing mean error of each
%                                  forest
%           E               ...    2nx2n Matrix of eigenvectors     
%           lambda          ...    2nx1 vector of corresponding eigenvalues   

%% Init 

% Get number of images
nImages = size(images, 2);

% Define number of features
nFeatures = 46;

% Get number of bone/background pixels per image
nContour = cellfun(@nnz,masks);

% imageDims = reshape(cell2mat(cellfun(@size,images,'uni',false)), 2, nImages);
% nPixPerImg = prod(imageDims);
% nPixels = sum(nPixPerImg);

% Init feature matrix
nPixels = sum(nContour) * 2;
features = zeros(nFeatures, nPixels);

% Init mask vector
maskVec = zeros(1,nPixels);

%% Calculate features for each image

% Init begin index
iBegin = 1;

% Iterate over all images
tic;
for i = 1:nImages
    % Get current end index
    iEnd = iBegin + 2*nContour(i) - 1;
    
    % Calculate features
    img = images{1,i};
    allFeatures = cache(@computeFeatures,img);
    
    % Select subset for random forest 
    msk = masks{1,i};
    iContour = find(msk);
    iBackground = find(msk==0);
    nBackground = length(iBackground);
    iRand = randperm(nBackground, nContour(i));
    iSelected = [iContour' iBackground(iRand)'];
    
    % Store cprresponding features + labels
    features(:,iBegin:iEnd) = allFeatures(:, iSelected);
    maskVec(iBegin:iEnd) = msk(iSelected);   
    
    % Update begin index for next iteration
    iBegin = iEnd + 1;
end
tImg = toc;
disp(strcat('Feature calculation: ',num2str(tImg)));
%% Create random forest(s)

% Get number of forests
nForests = length(nTreesPerForest);

% Init random forest and corresponduig error
rf = cell(1,nForests);
err = zeros(1,nForests);

for i = 1:nForests
    tic
    % a) Calculate random forest
    rf{i} = TreeBagger(nTreesPerForest(i), features', maskVec', 'OOBPred', 'on', 'OOBVarImp', 'on');
    
    % b) Calculate error
    err(i) = mean(oobError(rf{i}));
    
    tFor = toc;
disp(strcat('Forest calculation for ',num2str(nTreesPerForest(i)),' trees: ',num2str(tFor)));
end


if nargin == 4
    [E, lambda, meanS] = pcaShape(aligned);
end
