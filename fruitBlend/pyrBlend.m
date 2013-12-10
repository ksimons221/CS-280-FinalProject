clear all; clc; close all;

levels = 2;


oldData = load('restultPre.mat');



imageA = im2double(imread('leaves.jpg'));
imageB = im2double(imread('leaves.jpg'));

 [h, w d] =  size(imageA);


shift = 0;
 
resultsPercentage = zeros(10, 10);

originalString = 'Hello Amrit and Tim. texture work pls';

[ bitsToEncode, numBitsToEncode ] = createBitsToEncode( originalString );
bitsToEncode


currentString = '';

for i = 1 : size(bitsToEncode,2)
    currentString = strcat(currentString,num2str(bitsToEncode(i)));
end

reconstructedString = char(bin2dec(reshape(currentString,7,[]).')).';

dataSquare = zeros(10,10);

numBitsCanEncodeWithDiffSquares = zeros(1,10);

for currentContrastMagnitude = 10: 10

    for currentSquareSize = 10: 10
                        
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

                %[ newImage, results ] = changeContrast( imageA, imageB, levels, shift, contrastAdjust, squareSize  );
                
                [ newImage ] = blendWithMask( imageASample, imageBSample, contrastAdjust, shift, levels, squareSize );
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
    
    bitToEncode = 0;
    
    if bitCounter <= size(bitsToEncode, 2)
        bitToEncode = bitsToEncode(bitCounter);
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
                
    [ newImage ] = blendWithMask( imageASample, imageBSample, contrastAdjust, shift, levels, squareSize );

    [newH, newW, d] = size(newImage);

    if size(finalImage,1) == 1
        finalImage = zeros(cutsH*newH,newW*cutsW,3);
    end

    finalImage(   (i*newH)+1: (i+1)*newH,   (j*newW)+1: (j+1)*newW  , :) = newImage;
    
    bitCounter = bitCounter + 1;

    end
end
 
           

decodeSquare = squareSize;
subSquareSize = (decodeSquare*3) - 1;

 [h, w, ~] =  size(finalImage);


cutsW = floor(w / subSquareSize);
cutsH = floor(h / subSquareSize);

total = 0;
totalWrong = 0;

resultBits = zeros(1, cutsH * cutsW);

counter  = 1;
for i = 0 : cutsH - 1

    for j = 0 : cutsW - 1
        
        subImage = finalImage(   (i*subSquareSize)+1: (i+1)*subSquareSize,   (j*subSquareSize)+1: (j+1)*subSquareSize, :);
        [ bit ] = decodeImage( subImage, decodeSquare);
        resultBits(counter) = bit;
        counter = counter + 1;

    end
end

resultBits
imshow(finalImage);


