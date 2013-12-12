function [ decodedBits ] = decodeImageNaive( im )


[h,w,d] = size(im);

numBitsCanEncode = h*w*d;

decodedBits = ones(1, numBitsCanEncode);
counter = 1;
for row = 1 :h
    for col = 1 :w
        for colorBand = 1 :d
            pixelIntensity = im(row,col,colorBand);
            pixelLeastSignificantBit = mod(pixelIntensity,2);
            decodedBits(counter) = pixelLeastSignificantBit;
            counter = counter + 1;
        end
    end
end

end

