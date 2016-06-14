function [best, time] = optimizeP

close all
clear all
load handdata

[forest,~, E, ~, meanS] = train( images(1,1:30),masks,32,aligned );

prediction = predictLabel(forest,images(1,31:50));

% init 
best = zeros(8,20); %HAS TO BE CHANGED WHEN MIN AND MAX ARE CHANGED!!!
time = ones(1,20).*inf;
for i=1:20    
    f = makeOurCostFunction(prediction{1,i},meanS,E);
    
%     minima = [-1.5; -1.5; -1.5; -1.5; -1.5; -1.5; -1.5; -1.5; -1.5; -30; 0.5; 50; 100];  % ersten 9: Parameter der Eigenvektoren; rotation, scaling, x-translation, y-translation
%     maxima = [ 1.5;  1.5;  1.5;  1.5;  1.5;  1.5;  1.5;  1.5;  1.5;  30; 1.5;150; 200];
%     minima = [-3; -3; -3; -3; -3; -3; -3; -3; -3; -50; 0.5;   0;   0];  % ersten 9: Parameter der Eigenvektoren; rotation, scaling, x-translation, y-translation
%     maxima = [ 3;  3;  3;  3;  3;  3;  3;  3;  3;  50; 2; 300; 300];
    minima = [ -3; -3; -3; -3; -50; 0.5;   0;   0];  % ersten 4: Parameter der Eigenvektoren; rotation, scaling, x-translation, y-translation
    maxima = [  3;  3;  3;  3;  50;   2; 300; 300];
%     minima = [-1.5; -1.5; -1.5; -1.5; -30; 0.5; 50; 100];  % ersten 4: Parameter der Eigenvektoren; rotation, scaling, x-translation, y-translation
%     maxima = [ 1.5;  1.5;  1.5;  1.5;  30; 1.5;150; 200];

    tic
    best(:,i) = optimize( f, minima, maxima,[]);
    time(i) = toc;
    disp(strcat('optimization image ',num2str(i+30),': ',num2str(time(i))));
end
end

function f = makeOurCostFunction(predMask, mu, EigenVektors)

f = @ourCostFunction;

    function costs = ourCostFunction(params)

        % Hier kommt ihr in jeder iteration eines optimierungsschrittes
        % rein.
        
        % 1. read the parameters currently tested...
        b = params(1:end-4); 
        r = params(end-3);
        s = params(end-2);
        tx = params(end-1);
        ty = params(end);
         
        % 2. generate shape
        shape = generateShape( EigenVektors, mu, b, r, s, tx, ty); % landmarks fuer params berechnen
        
        % 3. calculate costs for generatedShape and predictedContourImage
        [y,x] = find(predMask);
        [~,d] = knnsearch([x y],shape');
        costs = sum(d);
        
        %Versuch einer 2. cost function -> hat aber gar nicht gut
        %funktioniert...
%         if (min(min(shape))<0 || max(shape(1,:))+2>size(predMask,2) || max(shape(2,:))+2>size(predMask,1))
%             costs = 1000;
%         else
%             costs = 64-sum(sum(predMask(round(shape(2,:))+1,round(shape(1,:))+1)));
%         end
    end
end
