function [ bitsToEncode, numBitsToEncode ] = createBitsToEncode( originalString )


decimalString = dec2bin(originalString);
decimalString = reshape(decimalString',1,numel(decimalString));
numBitsToEncode = size(decimalString,2);


bitsToEncode = zeros(1, numBitsToEncode);

for i = 1:numBitsToEncode
    character = decimalString(i);
    if character(1) == '1'
        bitsToEncode(i) = 1;
    else
        bitsToEncode(i) = 0;
    end

end

