function [  ] = plotShapePVar( E , mean , b)
%PLOTSHAPEPVAR plots the shape of all vectors and of reduced nr of eigenvectors
%   blau ...    reduced eigenvectors
%   red ...     complete model with all eigenvectors
% input:
%   E ...       Eigenvectors
%   mean ...    meanShape of the data (1x2nPoints)
%   b ...       vector of coefficients (1st column entries for all
%   eigenvectors, 2nd column with entries for the first k eigenvectors)

% Plot shape
figure()
hold on

% complete model
shape = generateShape(E, mean, b(:,1));
plot(shape(1,:), shape(2,:), 'r--');

% reduced eigenvector space
shape = generateShape(E, mean, b(:,2));
plot(shape(1,:), shape(2,:), 'b');

xlabel('X');
ylabel('Y');
legend('complete model','reduced model','location','SouthEast');
end
