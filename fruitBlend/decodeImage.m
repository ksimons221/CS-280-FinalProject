function [ results ] = decodeImage( newImage, squareSize )


[ rowAverage, colAverage ] = findSeam( rgb2gray(newImage), squareSize );

 
 [h, w, d] =  size(newImage);
 
 centerH = floor(h/2);
 centerW = floor(w/2);
  
  
 leftMostPoint = centerW - squareSize-3;
 rightMostPoint = centerW + squareSize-3;
 
 topMostPoint = centerH - squareSize-3;
 bottomMostPoint = centerH + squareSize-3;

 
 boxSize = 6;

 intrestSectionLeft = rowAverage(leftMostPoint: leftMostPoint+ boxSize);
 intrestSectionRight = rowAverage(rightMostPoint: rightMostPoint+ boxSize);

  intrestSectionTop = colAverage(topMostPoint: topMostPoint+ boxSize);
 intrestSectionBottom = colAverage(bottomMostPoint: bottomMostPoint+ boxSize);
 
 leftDeriv = pseudoDerivative(intrestSectionLeft);
 rightDeriv = pseudoDerivative(intrestSectionRight);
 topDeriv = pseudoDerivative(intrestSectionTop');
 bottomDeriv = pseudoDerivative(intrestSectionBottom');
 
 
 allDerivatives = (leftDeriv + topDeriv - rightDeriv - bottomDeriv); 
  
 r = abs(leftDeriv);
 [c, i] = max(r);

 
 results = sum(allDerivatives);
 
 if results < 0
     results = 0;
 else
     results = 1;
 end
 
 %r = rowAverage(45:55);
%plot(r);
%keyboard;

end





