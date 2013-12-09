function [ newImage, results ] = changeContrast( imageA, imageB, levels, shift, contrastAdjust  )



 [ newImage ] = blendWithMask(imageA, imageB, contrastAdjust, shift, levels);

 colorPlot = findSeam( newImage );

 
  [w] =  size(newImage,2);
 
 lookBehind = 2;
 
 
 leftMostPoint = floor(w/2) - 2;
 
 boxSize = (floor(w/2) - leftMostPoint) * 3;

 q = pseudoDerivative(colorPlot(leftMostPoint+lookBehind: leftMostPoint+ boxSize-lookBehind));
 r = abs(q);
 [c, i] = max(r);
 results = q(i);
 
 if results < 0
     results = -1;
 else
     results = 1;
 end
 
 
 r = colorPlot(45:55);
plot(r);
keyboard; 
end

