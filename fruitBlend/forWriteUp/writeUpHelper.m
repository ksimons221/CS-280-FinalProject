clear all; clc; close all;

levels = 1; 

imageName = 'apple.jpg';

imageA = im2double(imread(imageName));
imageB = im2double(imread(imageName));

 squareSize =  70;
 
 contrast = -70;
 
  [ newImage ] = blendWithMask( imageA, imageB, contrast, levels, squareSize );

   
  %imwrite(newImage, 'noBlendApple.png');