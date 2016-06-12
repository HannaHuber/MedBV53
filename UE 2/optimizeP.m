function [best] = optimizeP

close all
clear all
load handdata

[forest,~, E, lambda, meanS] = train( images(1,1:30),masks,10,aligned );

prediction = predictLabel(forest,images(1,31:50));

best = zeros(9,20);

for i=1:20
    f = makeOurCostFunction(prediction{1,i},meanS,E,lambda);
    
    minima = [-3; -3; -3; -3; -3; 0; 0.5; 0; 0];  % erste sechs: Parameter der Eigenvektoren; rotation, scaling, x-translation, y-translation
    maxima = [3; 3; 3; 3; 3; 359; 2; 500; 500];
    

    best(:,i) = optimize(f, minima, maxima,[]);
end
end

function f = makeOurCostFunction(predMask, mu, EigenVektors,EigenValues)

f = @ourCostFunction;

    function costs = ourCostFunction(params)

        % Hier kommt ihr in jeder iteration eines optimierungsschrittes
        % rein.
        
        % 1. read the parameters currently tested...
        b = params(1:5); 
        s = params(6);
        r = params(7);
        x = params(8);
        y = params(9);
         
        % 2. generate shape
        shape = generateShape( EigenVektors, mu, b, r, s, x, y); % landmarks fuer params berechnen
        
        % 3. calculate costs for generatedShape and predictedContourImage
        % here and return them
        [x,y] = find(predMask);
        [~,d] = knnsearch([x y],shape');
        costs = sum(d);
    end
end
