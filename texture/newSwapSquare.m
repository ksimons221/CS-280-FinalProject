function [ newStartRow, newStartCol ] = newSwapSquare(originalBoxSize, startRow, startCol, curH,curW )
   
    newBoxSize = (originalBoxSize * 2) - 1;

    centerH = (startRow * 2) - 1;
    
    centerW = (startCol * 2) - 1;
    
    newStartCol = max(1, centerH - ceil(newBoxSize / 2));
    
    if newStartCol + newBoxSize > curW
        newStartCol = curW - newBoxSize + 1;
    end
    
    newStartRow = max(1,centerW - ceil(newBoxSize / 2));
    if newStartRow + newBoxSize > curH
        newStartRow = curH - newBoxSize + 1;
    end
    
end

