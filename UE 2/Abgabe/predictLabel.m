function [ predMask ] = predictLabel( rf, images )
%PREDICTLABEL predicts on an image using a random forest
%   Input: rf              ...    1 x nForests cell of random forest objects (instance of Matlab's TreeBagger class)
%          images          ...    1 x nImages cell of training data images
%
%   Output: predMask       ...    1 x nImages cell of predicted masks

%% Init
% compute nr of images
nImages = size(images,2);

% init mask cell
predMask = cell(1,nImages);

%% predict mask of images
for i=1:nImages  
    % compute features of image and predict mask with features and random
    % forest
    testFeatures = computeFeatures(images{1,i});
    testPred = str2double(predict(rf{1,1}, testFeatures'));
    
    %reshape mask to image dimension
    dim=size(images{1,i});
    predMask{1,i} = reshape(testPred,[dim(1),dim(2)]);
end
end

