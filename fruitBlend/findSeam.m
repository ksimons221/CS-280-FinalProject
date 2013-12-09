function [ r ] = findSeam( image )

shiftAmout = 20;

grayIm = rgb2gray(image);

[h, w] = size(grayIm);

seam1 = floor(( w/2) - shiftAmout);
seam2 = floor(( w/2) + shiftAmout);

middle = floor(h/2);

boxSize = 10;


totalRow = grayIm(1, :);

for i = 2:h
    totalRow = totalRow + grayIm(i, :);
end

normalizedRow = totalRow./h;

%plot(normalizedRow);

r = normalizedRow;

end

