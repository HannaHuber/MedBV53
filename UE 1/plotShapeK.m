function [  ] = plotShapeK( E , mean , b, k)
%PLOTSHAPEPVAR plots the shape of all vectors and of reduced nr of eigenvectors
%   blau ...    reduced eigenvectors
%   red ...     complete model with all eigenvectors
% input:
%   E ...       Eigenvectors
%   mean ...    meanShape of the data (1x2nPoints)
%   b ...       vector of coefficients (entries for all eigenvectors)
%   k ...       different numbers of eigenvectors used for the model

% Plot shape
figure()
hold on

% complete model
shape = generateShape(E, mean, b);
plot(shape(1,:), shape(2,:), 'r--', 'LineWidth',1.3);
legs={'complete model'};

% reduced eigenvector space
for i=1:length(k)
    shape = generateShape(E, mean, b(1:k(i)));
    plot(shape(1,:), shape(2,:));
    legs = {legs{:} sprintf('%d eigenvectors',k(i))};
end

xlabel('X');
ylabel('Y');
legend(legs,'location','SouthEast');
end
