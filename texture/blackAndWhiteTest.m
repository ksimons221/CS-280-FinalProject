clear all; clc; close all;

smallTexture = imread('texture3.png'); 

im = rgb2gray(smallTexture);

numLevelsPyr = 5;

iterations = 2;


squareSize = 200;

numTiles = 2;

s = RandStream('mt19937ar','Seed',1);

largeNoise = rand(s,squareSize*numTiles, squareSize*numTiles);


finalImage = zeros(1,1);


for i = 0:numTiles-1
    for j = 0:numTiles-1
        squareOfNoise = largeNoise( (i*squareSize)+1 : (i+1)*squareSize, (j*squareSize)+1 : (j+1)*squareSize);
        newTexture = matchTextureLap(squareOfNoise, im, numLevelsPyr, iterations);

        [newH, newW, d] = size(newTexture);
        
        if size(finalImage,1) == 1
            finalImage = zeros(numTiles*newH, numTiles*newW);
        end
        
        finalImage(   (i*newH)+1: (i+1)*newH,   (j*newW)+1: (j+1)*newW) = newTexture;
        
    end
end





%newTexture = matchTextureLap(noise, im, numLevelsPyr, iterations);


h = fspecial('gaussian');

blurText = conv2(newTexture, double(h), 'same');


imshow(uint8(finalImage));


