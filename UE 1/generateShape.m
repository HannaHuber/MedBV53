function [ xNew ] = generateShape( E, m, b )
%GENERATESHAPE Generate shape defined by coefficient vector b
%   Input: E        ...     2nx2n Matrix of eigenvectors generated by pcaShape    
%          lambda   ...     2nx1 vector of corresponding eigenvalues
%          b        ...     kx1 vector of coefficients corresponding to the
%                           selected eigenvectors that are used to generate 
%                           the new shape (k <= 2n)
%          m        ...     2nx1 mean shape vector 
%   Output: xNew    ...     2xn generated shape, reshaped from 2nx1 shape vector: 
%                           xNew = m + sum_i=0:k (b(i)*E(:,i)
      
% Get number of used eigenvectors
k = length(b);

% Get number of landmarks per shape
n = size(E,1)/2;

%% Use standard deviation 
%lambda = sqrt(lambda);

% Generate new shape from first k eigenvectors
xNew = m + E(:,1:k)*b;%.*lambda(1:k));
xNew = reshape(xNew, 2, n);

end

