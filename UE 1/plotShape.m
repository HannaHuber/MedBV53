function [  ] = plotShape( E , lambda, mean )
%PLOTSHAPE plots the modes of the shapes within +-3 lambda
%   blau ...    different modes
%   red ...     mean shape
% input:
%   E ...       Eigenvectors
%   lambda ...  Eigenvalues (decending)
%   mean ...    meanShape of the data (1x2nPoints)

% resize the mean to (nPoints, 2 Dimensions)
nPoints = size(lambda,1)/2;
meanShape = reshape(mean',2,[])';

% Plot single modes
figure()
hold on
b = eye(nPoints*2);
for i = 1:nPoints*2
    mode = generateShape(E, lambda, mean, b(:,i));
    plot(mode(1,:), mode(2,:), 'b--');
end

% Plot the meanShape
plot(meanShape(:,1),meanShape(:,2),'r.');




% % Plot the different modes
% for i=1%:size(E)
%     % allocate b for +- 3
%     b1 = zeros(size(lambda));
%     b1([2*i-1 2*i]) = 3;
%     b2 = -b1;
%     
%     % calculate the new x and y values
%     xnew1 = mean + E'*(b1.*lambda);
%     xnew2 = mean + E'*(b2.*lambda);
%     
%     
%     
%     % reshape them into xnew(x,y)
%     xnew1 = reshape(xnew1,2,nPoints,[])';
%     xnew2 = reshape(xnew2,2,nPoints,[])';
% %     plot(xnew1(:,1),xnew2(:,2),'b.');
%     plot(xnew2(:,1),xnew2(:,2),'b.');
% end
end
% E = permute(reshape(E,2,nPoints,[]),[2 1 3]);
% lambda_temp = reshape(lambda,2,nPoints,[])';



