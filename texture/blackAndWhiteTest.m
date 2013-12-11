clear all; clc; close all;

smallTexture = imread('texture1.jpg'); 

im = rgb2gray(smallTexture);

numLevelsPyr = 5;

iterations = 1;

noise = rand(400, 400);

for i = 195:205
    col = noise(:,i);
    col = sortrows(col);
    %noise(:,i) = col;
end

%noise(121:150, 121:150) = 0;%(randi(80,50,50)./100) + .2;

%keyboard;

%noise(:, 1:200) = 1;

newTexture = matchTextureLap(noise, im, numLevelsPyr, iterations);

imshow(uint8(newTexture));


