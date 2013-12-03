    clear all; clc; close all;

levels = 5;


imageA = im2double(imread('apple.jpg'));
imageB = im2double(imread('apple.jpg'));

 [ outputImage ] = blendWithMask(imageA, imageB, -20, 2  5, levels);

%e = genPyr(outputImage, 'gauss', levels);
%r = magic(e, genPyr(maskABeforeReduction, 'gauss', levels));
%e_prime = blendedPyramid{levels};


%x  = rgb2gray(e{levels});
%x_prime = rgb2gray(e_prime);
%[dxx, dyx] = findPartialDerivative(x);
%[dxx4, dyx4] = findPartialDerivative(x_prime);


