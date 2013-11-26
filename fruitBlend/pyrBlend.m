clear all; clc; close all;

imga = im2double(imread('apple.jpg'));
imgb = im2double(imread('orange.jpg')); % size(imga) = size(imgb)
%imresize(imga,[size(imgb,1) size(imgb,2)]);

levels = 5;

limga = genPyr(imga,'lap',levels); % Laplacian pyramid 1
limgb = genPyr(imgb,'lap',levels); % Laplacian pyramid 2
newSize = size(limga{1}, 1);

v = ceil(newSize/2.0);


% Create a mask
maska = zeros(size(limga{1}));
maska(:,1:v,:) = 1;
maskb = 1-maska;
blurh = fspecial('gauss',50,25); % feather the border. Size then  sigma
maska = imfilter(maska,blurh,'replicate');
maskb = imfilter(maskb,blurh,'replicate');
maska = imfilter(maska,blurh,'replicate');
maskb = imfilter(maskb,blurh,'replicate');

imshow(maska);
maskABeforeReduction = maska;
maskBBeforeReduction = maskb;
% Done with mask


%creates blended pyramid
blendedPyramid = cell(1,levels); % the blended pyramid
blendedPyramid{1} = limga{1}.*maska + limgb{1}.*maskb;
for p = 2:levels
	%[Mp Np ~] = size(limga{p});
	%maskap = imresize(maska,[Mp Np]);
	%maskbp = imresize(maskb,[Mp Np]);
    maska = impyramid(maska, 'reduce');
    maskb = impyramid(maskb, 'reduce');
	blendedPyramid{p} = limga{p}.*maska + limgb{p}.*maskb;
end


imgo = collapsePyramid(blendedPyramid);   %%collapse
imwrite(imgo, 'outputImages/blendedImage.jpg');
%figure,imshow(imgo) % blend by pyramid
%imgo1 = maskABeforeReduction.*imga+maskBBeforeReduction.*imgb;
%figure,imshow(imgo1) % blend by feathering


