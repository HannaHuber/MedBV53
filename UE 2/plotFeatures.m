function [ featureImages ] = plotFeatures( image , features )

addpath TikZ
dim=size(image);
dimFeat=size(features,1);

featuresT=features';

featureImages = reshape(featuresT(:),[dim(1),dim(2),dimFeat]);

figure
image1 = imagesc(featureImages(:,:,1)');
colorbar
%matlab2tikz('figures/greyvalue.tex','height', '\figureheight', 'width', '\figurewidth');
figure
image2 = imagesc(featureImages(:,:,2)');
colorbar
%matlab2tikz('figures/gradientX.tex','height', '\figureheight', 'width', '\figurewidth');
figure
image3 = imagesc(featureImages(:,:,3)');
colorbar
%matlab2tikz('figures/gradientY.tex','height', '\figureheight', 'width', '\figurewidth');
figure
image4 = imagesc(featureImages(:,:,4)');
colorbar
%matlab2tikz('figures/magGrad.tex','height', '\figureheight', 'width', '\figurewidth');
figure
image5 = imagesc(featureImages(:,:,5)');
colorbar
%matlab2tikz('figures/haarGrey.tex','height', '\figureheight', 'width', '\figurewidth');
figure
image6 = imagesc(featureImages(:,:,25)');
colorbar
%matlab2tikz('figures/haarGrad.tex','height', '\figureheight', 'width', '\figurewidth');
figure
image7 = imagesc(featureImages(:,:,45)');
colorbar
%matlab2tikz('figures/coordX.tex','height', '\figureheight', 'width', '\figurewidth');
figure
image8 = imagesc(featureImages(:,:,46)');
colorbar
%matlab2tikz('figures/coordY.tex','height', '\figureheight', 'width', '\figurewidth');

end
