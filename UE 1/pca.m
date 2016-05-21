function [ E, lambda, k ] = pca( D, percentageVar )
%PCA computes the PCA of the data matrix
%   d ... dimension
%   n ... number of data 
%   Input: D                ...     dxn data matrix
%          percentageVar    ...     not mandatory; minimum percentage of the 
%                                   total variance captured by the model
%
%   Output:E        ...     2nx2n Matrix of eigenvectors     
%          lambda   ...     2nx1 vector of corresponding eigenvalues
%          k        ...     nr of first k eigenvectors to capture percentageVar 
%                           of the variance
%  

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
    while percentage_mom < percentageVar
        k = k+1;
        percentage_mom = percentage_mom + lambda(k)/lambda_tot;
    end
%     %prepare the output
%     E = E(:,1:k);
%     lambda = lambda(1:k);
end
end

