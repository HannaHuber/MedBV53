function [ C ] = ourCov( D )
%OURCOV Calculates covariance matrix C for dxn data matrix D
%   d ... dimension
%   n ... number of data points

% Get number of data points
n = size(D, 2);

% Calculate mean m
m = mean(D,2);

% Calculate x - m for every data point x
diffToMean = D - repmat(m, 1, n);

% Calculate covariance
C = (diffToMean * diffToMean') / (n-1);

end

