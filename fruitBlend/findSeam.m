function [ rowAverage, colAverage ] = findSeam( grayIm, squareSize )

[h, w] =  size(grayIm);
 
centerH = floor(h/2);
centerW = floor(w/2);

startH = centerH - squareSize;
endH = centerH + squareSize;

totalRow = grayIm(startH, :);

for i = startH+1:endH
    totalRow = totalRow + grayIm(i, :);
end

rowAverage = totalRow./(endH-startH);


startW = centerW - squareSize;
endW = centerW + squareSize;

totalCol = grayIm(:, startW);

for i = startW+1:endW
    totalCol = totalCol + grayIm(:, i);
end

colAverage = totalCol./(endW-startW);

end

