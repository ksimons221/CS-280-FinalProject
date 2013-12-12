clear all; clc; close all;

levels = 2; 

imageName = 'leaves.jpg';

imageA = im2double(imread(imageName));
imageB = im2double(imread(imageName));

 [h, w, ~] =  size(imageA);
 
resultsPercentage = zeros(10, 10);

originalString = 'Hello CS 280 Class :)';

[ bitsToEncode, numBitsToEncode ] = createBitsToEncode( originalString );

dataSquare = zeros(10,10);

numBitsCanEncodeWithDiffSquares = zeros(1,10);

for currentContrastMagnitude = 10: 10

    for currentSquareSize = 10: 10
        
        [currentContrastMagnitude, currentSquareSize]
        
        squareSize = currentSquareSize * 10;

        cutSize = squareSize * 3;

        cutsW = floor(w / cutSize) - 1;
        cutsH = floor(h / cutSize) - 1;

        finalImage = zeros(1,1,3);
    
        bitCounter = 1;
        
        totalBitsEncoded = 0;
        
        correct = 0;
        
        for i = 0 : cutsH

            for j = 0 : cutsW
                
                totalBitsEncoded = totalBitsEncoded + 1;
                
                contrastAdjust = currentContrastMagnitude * 1;
                
                imageASample = imageA((i*cutSize)+1:(i+1)*cutSize, (j*cutSize)+1:(j+1)*cutSize, :);
                imageBSample = imageB((i*cutSize)+1:(i+1)*cutSize, (j*cutSize)+1:(j+1)*cutSize, :);
                
                [ newImage ] = blendWithMask( imageASample, imageBSample, contrastAdjust, levels, squareSize );
                [ results ] = decodeImage( newImage, squareSize );
                
                if results == 1
                    correct = correct + 1;
                end
                
                [newH, newW, d] = size(newImage);

                if size(finalImage,1) == 1
                    finalImage = zeros(cutsH*newH,newW*cutsW,3);
                end

                finalImage(   (i*newH)+1: (i+1)*newH,   (j*newW)+1: (j+1)*newW  , :) = newImage;

                bitCounter = bitCounter + 1;

            end
        end
        dataSquare(currentContrastMagnitude, currentSquareSize) = correct / totalBitsEncoded;
        numBitsCanEncodeWithDiffSquares(currentSquareSize) = totalBitsEncoded;
    end

end

% can load the data if already saved
t = load('leavesDataSquare.mat');
dataSquare = t.dataSquare;

r = load('leavesNumBitsEncoded.mat');
numBitsCanEncodeWithDiffSquares = r.numBitsCanEncodeWithDiffSquares;



[currentContrastMagnitude, currentSquareSize, bitsWeNeedToEncode]=pickParamaters( dataSquare, numBitsCanEncodeWithDiffSquares, numBitsToEncode)
 

 %%%MAKE THE FINAL ENCODING
 
 if currentContrastMagnitude == -1        
    disp('There is to much data to encode')
    return;
 end
 
%Create the final image 

currentContrastMagnitude = currentContrastMagnitude * 7;

squareSize = currentSquareSize * 10;
cutSize = squareSize * 3;
cutsW = floor(w / cutSize) - 1;
cutsH = floor(h / cutSize) - 1;

finalImage = zeros(1,1,3);
bitCounter = 1;
                 
for i = 0 : cutsH

    for j = 0 : cutsW
    
    bitToEncode = 0;
    
    if bitCounter <= size(bitsToEncode, 2)
        bitToEncode = bitsToEncode(bitCounter);
    else
        bitToEncode = round(rand);
    end
           
    if bitToEncode == 1
        contrastAdjust = currentContrastMagnitude * 1;
    else
        contrastAdjust = currentContrastMagnitude * -1;    
    end
    
    if bitsWeNeedToEncode < bitCounter
        contrastAdjust = 0;
    end
   
    imageASample = imageA((i*cutSize)+1:(i+1)*cutSize, (j*cutSize)+1:(j+1)*cutSize, :);
    imageBSample = imageB((i*cutSize)+1:(i+1)*cutSize, (j*cutSize)+1:(j+1)*cutSize, :);
                
    [ newImage ] = blendWithMask( imageASample, imageBSample, contrastAdjust, levels, squareSize );

    [newH, newW, d] = size(newImage);

    if size(finalImage,1) == 1
        finalImage = zeros(cutsH*newH,newW*cutsW,3);
    end

    finalImage(   (i*newH)+1: (i+1)*newH,   (j*newW)+1: (j+1)*newW  , :) = newImage;
    
    bitCounter = bitCounter + 1;

    end
end
 
%%% Finished encoding the image. Now we need to reconstruct bits           

[ resultBits ] = reconstructBits( finalImage, squareSize)

imshow(finalImage);  %the final tiled image

