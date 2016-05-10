function [ E, lambda ] = pca( D, percentage )
%PCA computes the PCA of the data matrix D dxn
%   d ... dimension
%   n ... number of data points
%   E contains the Eigenvectors to the corresponding eigenvalues of lambda
%   (which are in decending order)
%
% percentage is not mandatory; if given the highest eigenvalues are given
% back such that percentage of the variance is at least within these
% principal components

% Step 1: Compute the empirical mean & subtract it from the data and calculate empirical covariance matrix
C_D = ourCov(D);

% Step 2: Compute eigenvalue decomposition of the covariance matrix
[E,lambda] = eig(C_D);
lambda = diag(lambda);
% to get the output in descending order of eigenvalues & in case of 3D as
% diag matrix
E = fliplr(E);
lambda = flipud(lambda);

%% if only the highest eigenvalues shall be taken according to percentage
if nargin == 2
    %calculate the total variance
    lambda_tot = sum(lambda);
    %find how many principal components are necessary
    k = 0;
    percentage_mom = 0;
    while percentage_mom < percentage
        k = k+1;
        percentage_mom = percentage_mom + lambda(k)/lambda_tot;
    end
    % prepare the output
    E = E(:,1:k);
    lambda = lambda(1:k);
end
end

