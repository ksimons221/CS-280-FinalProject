function [ resultBits ] = reconstructBits( finalImage, decodeSquare )


subSquareSize = (decodeSquare*3) - 1;

 [h, w, ~] =  size(finalImage);

cutsW = floor(w / subSquareSize);
cutsH = floor(h / subSquareSize);

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


end

