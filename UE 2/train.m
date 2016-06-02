function [ rf ] = train( images, masks, nTrees )
%TRAIN trains random forest 
%   Input: images   ...     n x m x nImages matrix of training data images   
%          masks    ...     n x m x nImages matrix of corrsponding labels
%          nTrees    ...    number of trees in the random forest
%   Output: rf      ...     random forest (instance of Matlab's TreeBagger class)

% Get number of images
nImages = size(images, 3);

nFeatures = 8;
nPixels = size(images,1)*size(images,2);

% Init feature matrix
features = zeros(nFeatures, nPixels, nImages);

% Init matrix for vector storage
imageVec = zeros(nPixels, nImages);
maskVec = zeros(nPixels, nImages);
% 
% % Calculate features for each image
% for i = 1:nImages
%     % Calculate features
%     features(:,:,i) = computeFeatures(images(:,:,i));
%     
%     % Store image and mask as vector
%     img = images(:,:,i);
%     imageVec(:,i) = img(:);
%     msk = masks(:,:,i);
%     maskVec(:,i) = msk(:);    
% end
% 
% % Get sets indices corresponding to bone contour and background
% contourInd = maskVec>0;
% backgrInd = maskVec==0;
% 
% % Select random indices of background subset of same size as contour set
% nContour = length(contourInd);
% nBackgr = length(backgrInd);
% randInd = randperm(nBackgr, nContour);
%   
% % Create random forest
% selected = [contourInd backgrInd(randInd)];
% rf = TreeBagger(nTrees, features(selected)', maskVec(selected)');

end
