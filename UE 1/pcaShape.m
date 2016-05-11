function [ E, lambda , meanShape ] = pcaShape( aligned )
%pcaShape computes PCA of the shape data in aligned that is given as
%'nPoints x nDimensions x nShapes'
%   n ... number of data points
%   d ... dimension of data points
%   s ... number of shapes

% get number of data points
n = size(aligned,1);

% get dimension of data points
d = size(aligned,2);

% get number of shapes
s = size(aligned,3);

% reshape data into matrix so each data point corresponds to one column
newShape = reshape(permute(aligned,[2,1,3]),n*d,s);

% compute PCA
[E, lambda] = pca(newShape);

% compute mean
meanShape = mean(newShape,2);
end

