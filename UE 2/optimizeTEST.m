function optimizeTEST

close all
clear all
load handdata

[forest, EV, EW, m] = train( images,masks,aligned );

prediction = predictSegmentation(images{1,1},forest);

f = makeOurCostFunction(prediction,m,EV,EW);



minima = [-2; -2; -2; -2; -2; -2; 0.5; 0; 0; 0];  % erste sechs: Parameter der Eigenvektoren; scaling, rotation, x-translation, y-translation
maxima = [2; 2; 2; 2; 2; 2; 2; 359; 500; 500];


optimize(f, minima, maxima,[]);
end

function f = makeOurCostFunction(predictedContourImage, mu, EigenVektors,EigenValues)

f = @ourCostFunction;

    function costs = ourCostFunction(params)

        % Hier kommt ihr in jeder iteration eines optimierungsschrittes
        % rein.
        
        % 1. read the parameters currently tested...
        b = params(1:6); % ersten sechs Eigenvektoren enthalten 98.15 Prozent der Varianz
        s = params(7);
        r = params(8);
        x = params(9);
        y = params(10);
         
        % 2. generate shape
        %generatedShape = generateShape( b, s, r, x, y, EigenVektors, mu ); % landmarks fuer params berechnen
        
        % 3. calculate costs for generatedShape and predictedContourImage
        % here and return them
        costs = 1000;
    end
end
