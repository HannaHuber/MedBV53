%% Ex. 2 - PCA
clear all
close all

load daten

data=data1';
[E,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)
data=data2';
[E,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)
data=data3';
[E,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)
data=data4';
[E,l] = pca(data);
plot2DPCA(data, mean(data), data, E, l, 1, 0)

%% Ex. 5 - Shape Modell
clear all 
close all

load shapes