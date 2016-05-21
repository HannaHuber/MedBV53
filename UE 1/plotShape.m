function [  ] = plotShape( E , mean , b)
%PLOTSHAPE plots the shapes defined by b
%   blue ...    negative multiple of lambda
%   red ...     mean shape
%   green ...   positive multiple of lambda
% input:
%   E ...       Eigenvectors
%   mean ...    meanShape of the data (1x2nPoints)
%   b ...       vector of coefficients

% Plot the different modes
for f=1:13
    figure()
    hold on
    for i=-3:3
        shape = generateShape(E, mean, i*b(:,f));
        if i<0
            plot(shape(1,:), shape(2,:), 'b--');
        elseif i==0
            plot(shape(1,:), shape(2,:), 'r');
        elseif i>0
            plot(shape(1,:), shape(2,:), 'g--');
        end
    end
    
    lambda = diag(b.*b);
    title(sprintf('%d. mode with %.2f%% of total variance',f,lambda(f)/sum(lambda)*100))
    xlabel('X');
    ylabel('Y');
end
end
