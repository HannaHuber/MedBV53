function [ xRec, xSub, err] = project( x, A, sub )
%PROJECT project data points onto subspace and transform to original
%        coordinate system
% Input:    x      ...  dxn matrix of data points
%           A      ...  dxd matrix of basis vectors
%           sub    ...  1xk vector of coordinate indices spanning subspace
% Output:   xRec  ...  dxn matrix of reconstructed (= projected + transformed to
%                       original space) data points
%           err    ...  mean error between original and reconstructed data
%                       points

% Get number of data points
n = size(x, 2);

% Get space dimension
d = size(x, 1);

% Get subspace dimension
k = length(sub);

% Center data
m = mean(x, 2);
xCentered = x - repmat(m, 1, n);

% Project data (contains subspace AND eliminated components)
xProj = A' * xCentered;

% Subspace components
xSub = xProj(sub, :);

% Eliminated components
elimCoords = setdiff(1:d, sub);
xElim = xProj(elimCoords, :);

% Embed subspace components in d-dimensional space by adding zeros
xSubD = zeros(d,n);
xSubD(sub,:) = xSub; 

% Reconstruct data
xRec = (A') \ xSubD + repmat(m, 1, n);

% Get mean error from eliminated coords
err = mean(sqrt(sum(xElim.^2,1)));

end

