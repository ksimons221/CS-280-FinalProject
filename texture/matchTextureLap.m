function [ im ] = matchTextureLap( noise, texture, numLevelsPyr, iterations )

texturePyramid = genPyr(texture, 'lap', numLevelsPyr);

im = matchHistogram(noise, texture);

lowValueSwap = 10;
highValueSwap = 90;

for i = 1:iterations
    i
    noiseTexture = genPyr(im, 'lap', numLevelsPyr);
    for j = 1:numLevelsPyr
        toReplace = matchHistogram(noiseTexture{j}, texturePyramid{j});
        
         noiseTexture{j} = toReplace;

        if j == 5
           %keyboard;
           squareSize = 6;
           moveAmount = .2;
           startRow = ceil(size(toReplace, 2)*.7);
           startCol = ceil(size(toReplace, 2)*moveAmount);          
           rangeOfValue = max(max(toReplace)) - min(min(toReplace));
           adjustedLow = min(min(toReplace)) + (rangeOfValue*lowValueSwap)/256;
           adjustedHigh = min(min(toReplace)) + (rangeOfValue*highValueSwap)/256;
           [ swappedIm, indexes ] = swap( toReplace, adjustedLow, adjustedHigh, squareSize, startRow - ceil(squareSize/2), startCol- ceil(squareSize/2), round(moveAmount));
            noiseTexture{j} = swappedIm;
            numSwaps = size(indexes, 1);
            
            for k = 4:-1:1
                newSquareSize = (squareSize * 2) - 1;
                currentIm = noiseTexture{k};
                [curH, curW] = size(currentIm);
                for singleSwap = 1:numSwaps
                    %[k, singleSwap]
                    if k == -4 && singleSwap == 5
                        keyboard;
                    end
                    currentSwapRow = indexes(singleSwap, :);
                    [ newStartRow1, newStartCol1 ] = newSwapSquare(squareSize, currentSwapRow(1), currentSwapRow(2),curH,curW );
                    [ newStartRow2, newStartCol2 ] = newSwapSquare(squareSize, currentSwapRow(3), currentSwapRow(4),curH,curW );
                    currentIm = swapPatch( currentIm, newStartRow1, newStartCol1, newStartRow2, newStartCol2, newSquareSize);
                end
                squareSize = newSquareSize
                
                
            end
            

        end

    end
    
    im = collapsePyramid(noiseTexture);
    im = matchHistogram(im, texture);
end


end

