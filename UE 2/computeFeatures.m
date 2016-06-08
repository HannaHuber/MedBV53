function [ imageFeatures ] = computeFeatures( image )
%COMPUTEFEATURES computes different features for a greyscale image
%   Input: image          ...  n x m Matrix of grey values
%   Output: imageFeatures ...  46 x n*m Matrix of features (one per row)

% get size in pixels
dim=size(image);

% convert image to double (necessary for Haarlike)
image=im2double(image);

% Init feature matrix
imageFeatures=zeros(44,dim(1)*dim(2));

% greyvalue
imageVec=image(:)';
imageFeatures(1,:)=imageVec;

% gradient
[grad1a,grad2a]=gradient(image);
grad1=grad1a(:)';
grad2=grad2a(:)';
imageFeatures(2,:)=grad1;
imageFeatures(3,:)=grad2;

% magnitude of the gradient
maggrad=sqrt(grad1.*grad1+grad2.*grad2);
imageFeatures(4,:)=maggrad;

% Haar-like features of the gray value image
imageFeatures(5:24,:)=computeHaarLike(image);

% Haar-like features of the gradient magnitudes
maggradMatrix= reshape(maggrad,dim(1), dim(2)); % vec2mat(maggrad,dim(1))';
imageFeatures(25:44,:)=computeHaarLike(maggradMatrix);

% x- and y- coordinates of a pixel
dimensionVectorXshort=1:dim(1);
dimensionVectorX=repmat(dimensionVectorXshort,1,dim(2));
imageFeatures(45,:)=dimensionVectorX;

dimensionVectorYshort=1:dim(2);
dimensionMatrixY=repmat(dimensionVectorYshort,dim(1),1);
imageFeatures(46,:)=dimensionMatrixY(:)';





