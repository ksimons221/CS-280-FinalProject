clear all; clc; close all;

smallTexture = imread('texture1.jpg'); 

smallTextureGray = rgb2gray(smallTexture);

numLevelsPyr = 5;

iterations = 1;


[w, h, ~] = size(smallTexture);
[im, M, means_d] = colorshape(smallTexture);
im = im';

im_r = reshape(im(:,1), w, h);
im_g = reshape(im(:,2), w, h);
im_b = reshape(im(:,3), w, h);

keyboard;
newRTexture = matchTexture(rand(300, 300), im_r, numLevelsPyr, iterations);
[h, w] = size(newRTexture);
out_r = reshape(newRTexture, h*w, 1);

newGTexture = matchTexture(rand(300, 300), im_g, numLevelsPyr, iterations);
out_g = reshape(newGTexture, h*w, 1);

newBTexture = matchTexture(rand(300, 300), im_b, numLevelsPyr, iterations);
out_b = reshape(newBTexture, h*w, 1);

out = double([out_r, out_g, out_b])';
out = (M^-1)*out;
keyboard;
out_im= out + [ones(h*w,1)*means_d(1) ,ones(h*w,1)*means_d(2), ones(h*w,1)*means_d(3)];


keyboard;