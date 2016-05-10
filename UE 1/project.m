function [ p ] = project( x, A )
%PROJECT project data points in dxn matrix x to subspace defined by dxk matrix A

% Get number of data points
n = size(x, 2);

% Center data
m = mean(x, 2);
xCentered = x - repmat(m, 1, n);

% Project to subspace
p = A' * xCentered;

end

