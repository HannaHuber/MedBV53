function [best] = optimizeP

close all
clear all
load handdata

[forest,~, E, lambda, meanS] = train( images(1,1:30),masks,32,aligned );

prediction = predictLabel(forest,images(1,31:50));

best = zeros(13,20);

for i=1:20    
    f = makeOurCostFunction(prediction{1,i},meanS,E,lambda);
    
    minima = [-3; -3; -3; -3; -3; -3; -3; -3; -3; -50; 0.5;   0;   0];  % erste 9: Parameter der Eigenvektoren; rotation, scaling, x-translation, y-translation
    maxima = [ 3;  3;  3;  3;  3;  3;  3;  3;  3;  50;   2; 300; 300];
    
    tic
    best(:,i) = optimize( f, minima, maxima,[]);
    tFor = toc;
    disp(strcat('optimization image ',num2str(i+30),': ',num2str(tFor)));
end
end

function f = makeOurCostFunction(predMask, mu, EigenVektors,EigenValues)

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
    end
end
