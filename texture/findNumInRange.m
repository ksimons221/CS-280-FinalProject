function [ energy ] = findNumInRange(im, lowRange, highRange, squareSize )

[h, w] = size(im);
energy = zeros(h, w);
squareSide = ceil(squareSize/2);


for i = 1+squareSide:h - squareSide
   for j = 1+squareSide:w - squareSide
        subImage = im(i-squareSide:i+squareSide, j-squareSide:j+squareSide);
        val = length(find(subImage > lowRange &  subImage < highRange));
        energy(i,j) = val;
   end
 
end

