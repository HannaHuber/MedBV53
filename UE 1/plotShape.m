function [  ] = plotShape( E , mean , b)
%PLOTSHAPE plots the shapes defined by b
%   blau ...    different shapes
%   red ...     mean shape
% input:
%   E ...       Eigenvectors
%   mean ...    meanShape of the data (1x2nPoints)
%   b ...       vector of coefficients

% Plot the different shapes
figure()
hold on
for i=1:size(b,2)
    shape = generateShape(E, mean, b(:,i));
    plot(shape(1,:), shape(2,:), 'b--');
end

% Plot the meanShape
meanShape = generateShape(E, mean, zeros(size(b,1),1));
plot(meanShape(1,:),meanShape(2,:),'r');

xlabel('X');
ylabel('Y');
end
