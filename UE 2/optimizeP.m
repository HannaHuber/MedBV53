function [best, time] = optimizeP
% close all
% clear all
load handdata

% calculate the forest and the shapeModel using the training set
[forest,~, E, lambda, meanS] = train( images(1,1:30),masks,32,aligned );
% predict on the test set 
prediction = predictLabel(forest,images(1,31:50));

% init of optimization
best = zeros(8,20); %HAS TO BE CHANGED WHEN MIN AND MAX ARE CHANGED!!!
time = ones(1,20).*inf;
for i=1:20  
    % get the Costfunction-handle
    f = makeOurCostFunction(prediction{1,i},meanS,E);
    
    % different min, max-settings: 9 eigenvectors contain 99% of variance
    % of the shape model, 4 eigenvectors contain 95%;
    
    % Small optimization range: 9 eigenvectors of shape, rotation, scaling, x-translation, y-translation
%     minima = [-1.5; -1.5; -1.5; -1.5; -1.5; -1.5; -1.5; -1.5; -1.5; -30; 0.5; 50; 100];  
%     maxima = [ 1.5;  1.5;  1.5;  1.5;  1.5;  1.5;  1.5;  1.5;  1.5;  30; 1.5;150; 200];
    % Large optimization range: 9 eigenvectors of shape, rotation, scaling, x-translation, y-translation
%     minima = [-3; -3; -3; -3; -3; -3; -3; -3; -3; -50; 0.5;   0;   0];  
%     maxima = [ 3;  3;  3;  3;  3;  3;  3;  3;  3;  50; 2; 300; 300];
    % Small optimization range: 4 eigenvectors of shape, rotation, scaling, x-translation, y-translation
%     minima = [-1.5; -1.5; -1.5; -1.5; -30; 0.5; 50; 100];  
%     maxima = [ 1.5;  1.5;  1.5;  1.5;  30; 1.5;150; 200];
    % Large optimization range: 4 eigenvectors of shape, rotation, scaling, x-translation, y-translation
%     minima = [ -3; -3; -3; -3; -50; 0.5;   0;   0];  
%     maxima = [  3;  3;  3;  3;  50;   2; 300; 300];
    % Large optimization range based on std: 4 eigenvectors of shape, rotation, scaling, x-translation, y-translation
    minima = [ -3.*sqrt(lambda(1:4)); -50; 0.7;   0;   0];  
    maxima = [  3.*sqrt(lambda(1:4));  50;   1.2; 300; 300];

    % optimize and measure the necessary time
    tic
    best(:,i) = optimize( f, minima, maxima,[]);
    time(i) = toc;
    disp(strcat('optimization image ',num2str(i+30),': ',num2str(time(i))));
end
end

function f = makeOurCostFunction(predMask, m, EigenVektors)

f = @ourCostFunction;

    function costs = ourCostFunction(params)     
        % 1. read the currently tested parameters 
        b = params(1:end-4); 
        r = params(end-3);
        s = params(end-2);
        tx = params(end-1);
        ty = params(end);
         
        % 2. generate the according shape
        shape = generateShape( EigenVektors, m, b, r, s, tx, ty);
        
        % 3. calculate the costs
        % find the x-y coordinates of the bone-boundary in the predicted
        % mask
        [y,x] = find(predMask);
        % find the euclidean distance of each landmark to the nearest point
        % in the mask
        [~,d] = knnsearch([x y],shape');
        % add up all distances
        costs = sum(d);
        
        % trial of 2. cost function -> classification very poor, since the
        % condition is too strong
%         if (min(min(shape))<0 || max(shape(1,:))+2>size(predMask,2) || max(shape(2,:))+2>size(predMask,1))
%             costs = 1000;
%         else
%             costs = 640-sum(sum(predMask(round(shape(2,:))+1,round(shape(1,:))+1)));
%         end
    end
end
