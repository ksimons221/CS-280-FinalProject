clear all; clc; close all;

levels = 2;




imageA = im2double(imread('orange.jpg'));
imageB = im2double(imread('orange.jpg'));

squareSize = 100;

shift = 0;
contrastAdjust = 3;

for i = 0 : 4
    
for j = 0 : 4
    
imageASample = imageA((i*squareSize)+1:(i+1)*squareSize, (j*squareSize)+1:(j+1)*squareSize, :);
imageBSample = imageB((i*squareSize)+1:(i+1)*squareSize, (j*squareSize)+1:(j+1)*squareSize, :);



[ newImage, results ] = changeContrast( imageASample, imageBSample, levels, shift, contrastAdjust);


stiched = imageA;
stiched(2:100, 2:100,:) = newImage;


disp('Adjusted');


disp(contrastAdjust);

disp('Guess');


disp(results * abs(contrastAdjust));

end
end
%{ 
 [ outputImage ] = blendWithMask(imageA, imageB, contrastAdjust, shift, levels);

 t = findSeam( outputImage );
 %imshow(outputImage);

 %figure(2);
 
 
Aprime = rgb2gray(collapsePyramid(genPyr(imageA, 'lap', levels)));
grayOut = rgb2gray(outputImage);

diff = abs(Aprime - grayOut).*255;



%leftMostPoint = 0;
%for i= 1 : 509
%    if diff(1,i) ~= 0 
 %       disp(i)
  %      leftMostPoint = i;
   %     break
    %end
%end
 [h, w] =  size(diff);
 
 lookBehind = 2;
 
 
 leftMostPoint = floor(w/2) - 2;
 
 boxSize = ((w/2) - leftMostPoint) * 3;
 rightBefore =  t(leftMostPoint-lookBehind: leftMostPoint-1);
 rightAfter =  t(leftMostPoint+ boxSize+1: leftMostPoint+ boxSize+lookBehind);
 averageSlope = mean(pseudoDerivative(rightBefore));% + pseudoDerivative(rightAfter)));

 
 pixelValueBefore = t(leftMostPoint);
 projectedPixelValueAfter = pixelValueBefore + (averageSlope * boxSize);
 pixelValueAfter = t(leftMostPoint+boxSize);

 
 q = pseudoDerivative(t(leftMostPoint+lookBehind: leftMostPoint+ boxSize-lookBehind));
 r = abs(q);
 [c, i] = max(r);
 value = q(i);
 disp(value);
 
 
 %disp(pixelValueAfter - projectedPixelValueAfter);
 
 
 
 %plot(t(leftMostPoint: leftMostPoint+ boxSize));
 x = t(leftMostPoint: leftMostPoint+ boxSize);

 %plot(t(leftMostPoint-lookBehind: leftMostPoint+ boxSize+lookBehind))
 
%e = genPyr(outputImage, 'gauss', levels);
%r = magic(e, genPyr(maskABeforeReduction, 'gauss', levels));
%e_prime = blendedPyramid{levels};


%x  = rgb2gray(e{levels});
%x_prime = rgb2gray(e_prime);
%[dxx, dyx] = findPartialDerivative(x);
%[dxx4, dyx4] = findPartialDerivative(x_prime);
%}

