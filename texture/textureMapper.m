clear all; clc; close all;

smallTexture = imread('texture1.jpg');

smallTextureGray = rgb2gray(smallTexture);

numLevelsPyr = 5;

iterations = 6;

noise = rand(250,250);


biggerTexture = matchTexture( noise, smallTextureGray, numLevelsPyr, iterations );