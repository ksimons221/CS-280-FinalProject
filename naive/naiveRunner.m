clear all; clc; close all;

levels = 2; 

imageName = 'leaves.jpg';

originalImage = imread(imageName);

im = imread(imageName);


[h,w,d] = size(im);

numBitsCanEncode = h*w*d;

bitsToEncode = rand(1,numBitsCanEncode);
bitsToEncode = round(bitsToEncode);

counter = 1;
for row = 1 :h
    for col = 1 :w
        for colorBand = 1 :d
            pixelIntensity = im(row,col,colorBand);
            pixelLeastSignificantBit = mod(pixelIntensity,2);
            bitToEncode = bitsToEncode(counter);
            if pixelLeastSignificantBit ~= bitToEncode
                if pixelIntensity < 128
                    pixelIntensity = pixelIntensity +1;
                else
                    pixelIntensity = pixelIntensity -1;
                end
            end
             im(row,col,colorBand) = pixelIntensity;
            counter = counter + 1;
        end
    end
end


[decodedBits] = decodeImageNaive( im );

diff = decodedBits - bitsToEncode;
sumDiff = sum(diff);

imwrite(im,'modified.png');

readModifed = imread('modified.png');
keyboard;
[decodedBitsAfterSave] = decodeImageNaive( readModifed );

numDifferent = 0;

disp('Last Check');

for i = 1: numBitsCanEncode
    if decodedBitsAfterSave(i) ~= bitsToEncode(i)
        numDifferent = numDifferent + 1;
    end
end

numDifferent

numDifferent/numBitsCanEncode


