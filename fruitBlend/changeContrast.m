function [ newImage, results ] = changeContrast( imageA, imageB, levels, shift, contrastAdjust, squareSize  )



[ newImage ] = blendWithMask(imageA, imageB, contrastAdjust, shift, levels, squareSize);


[ results ] = decodeImage( newImage, squareSize );


end
