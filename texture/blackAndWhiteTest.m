clear all; clc; close all;

smallTexture = imread('fur.png'); 

im = rgb2gray(smallTexture);

numLevelsPyr = 5;

iterations = 3;

noise = rand(300, 300);


%noise(121:150, 121:150) = 0;%(randi(80,50,50)./100) + .2;

%keyboard;

%noise(:, 1:200) = 1;

newTexture = matchTextureLap(noise, im, numLevelsPyr, iterations);


h = fspecial('gaussian');

blurText = conv2(newTexture, double(h), 'same');


imshow(uint8(blurText));


