clear all; clc; close all;

smallTexture = imread('tile2.jpg'); 

%baseLineTexture = imread('baseLineTexture.png');
%[ baseLineEnergy ] = findNumInRange(baseLineTexture, 85, 115, 32 );


im = rgb2gray(smallTexture);

numLevelsPyr = 5;

iterations = 1;


squareSize = 200;
numTiles = 2;
s = RandStream('mt19937ar','Seed',1);
largeNoise = rand(s,squareSize*numTiles, squareSize*numTiles);
finalImage = zeros(1,1);

for i = 0:numTiles-1
    for j = 0:numTiles-1
        squareOfNoise = largeNoise( (i*squareSize)+1 : (i+1)*squareSize, (j*squareSize)+1 : (j+1)*squareSize);
        newTexture = matchTextureLap(double(squareOfNoise), double(im), numLevelsPyr, iterations);

        [newH, newW, d] = size(newTexture);
        
        if size(finalImage,1) == 1
            finalImage = zeros(numTiles*newH, numTiles*newW);
        end
        
        finalImage(   (i*newH)+1: (i+1)*newH,   (j*newW)+1: (j+1)*newW) = newTexture;
        
    end
end



%noise = load('noise.mat');
%noise = noise.noise; 


%newTexture = matchTextureLap(noise, im, numLevelsPyr, iterations);
%[$ newEnergy ] = findNumInRange(newTexture, 88, 112, 32 );


h = fspecial('gaussian');

%blurText = conv2(newTexture, double(h), 'same');
%blurText = conv2(blurText, double(h), 'same');

imshow(uint8(finalImage));

