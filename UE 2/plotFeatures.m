function [ featureImages ] = plotFeatures( image , features )


dim=size(image);
dimFeat=size(features,1);

featuresT=features';

featureImages = reshape(featuresT(:),[dim(1),dim(2),dimFeat]);

figure
image1 = imagesc(featureImages(:,:,1));
colorbar
figure
image2 = imagesc(featureImages(:,:,2));
colorbar
figure
image3 = imagesc(featureImages(:,:,3));
colorbar
figure
image4 = imagesc(featureImages(:,:,4));
colorbar
figure
image5 = imagesc(featureImages(:,:,5));
colorbar
figure
image6 = imagesc(featureImages(:,:,25));
colorbar
figure
image7 = imagesc(featureImages(:,:,45));
colorbar
figure
image8 = imagesc(featureImages(:,:,46));
colorbar


