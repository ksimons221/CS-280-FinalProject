function [ newIm, swapIndexes ] = swap( im, valueLow, valueHigh, squareSize, startRow, startCol ) 


    %swapIndexes is numSwaps by 4. Each row is x1, y1, x2, y2
    
    newIm = im;

    [rows, cols, ~] = find(im >= valueLow & im <= valueHigh);

    numElements = length(rows)

    
    s = RandStream('mt19937ar','Seed',0);
    
    vec1 =randperm(s,squareSize^2);

    vec2 =randperm(s, numElements);
    
    per = numElements/(squareSize.^2);
    limit = 0.4;
    
    if per < limit
        numSwaps = numElements;
    else
        numSwaps = ceil(limit*squareSize.^2);
    end    

    numSwaps = min(numElements, squareSize^2)
    swapIndexes = zeros(numSwaps, 4);
     
    
    for i = 1:numSwaps

        % where to insert in middle square
        insertRow = mod(vec1(i),  squareSize) + startRow;
        insertCol = ceil(vec1(i)/ squareSize) - 1 + startCol;

        %In square
        oldVal = im(insertRow,insertCol);

        %where it is coming from
        swapX = rows(vec2(i));
        swapY = cols(vec2(i));


        %val moving to square
        moveToSquare = im(swapX, swapY);

        %location out of square
        newIm(swapX, swapY) = oldVal;

        %location in square
        newIm(insertRow, insertCol) = moveToSquare;
        
        swapIndexes(i,:) = [insertRow,insertCol,swapX,swapY];

    end
end

