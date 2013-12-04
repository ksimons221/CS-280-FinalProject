clear all; clc; close all;

smallTexture = imread('texture1.jpg');

smallTextureGray = rgb2gray(smallTexture);

numLevelsPyr = 4;

iterations = 5;

noise = rand(250,250);

%YOU MIGHT NEED TO SCALE THINGS
% Noise is in a double [0 to 1] and smallTextureGray is int [0 to 255]


biggerTexture = matchTexture( noise, smallTextureGray, numLevelsPyr, iterations );