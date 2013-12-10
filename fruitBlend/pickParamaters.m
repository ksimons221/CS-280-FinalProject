function [ contrastMag, squareSize, bitsWeNeedToEncode ] = pickParamaters( dataSquare, squareSizes, numBitsToEncode )

contrastMag = -1;

squareSize = -1;

temp = 0;

for i = 1:10
    for j = 1:10
        
        if dataSquare(i,j) > .80
        
            errorRecorded = 1-  dataSquare(i, j);
            bitsWeCanEncode = squareSizes(j);
            if bitsWeCanEncode > temp
                temp = bitsWeCanEncode;
            end
            bitsWeNeedToEncode = numBitsToEncode + ceil((errorRecorded*2*numBitsToEncode));
            
            if bitsWeCanEncode > bitsWeNeedToEncode
                contrastMag = i;
                squareSize = j;
                return
            end
        end
    end
end

%]temp

end

