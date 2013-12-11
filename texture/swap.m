function [ newIm ] = swap( im, valueLow, valueHigh, squareSize, startX, startY ) 


    newIm = im;

    [rows, cols, ~] = find(im >= valueLow & im <= valueHigh);

    numElements = length(rows);

    vec1 =randperm(squareSize^2);

    vec2 =randperm(numElements);
    
    per = numElements/(squareSize.^2);
    limit = 0.4;
    
    if per < limit
        numSwaps = numElements;
    else
        numSwaps = ceil(limit*squareSize.^2);
    end    

     numSwaps = numElements
    
    for i = 1:numSwaps

        % where to insert in middle square
        insertX = mod(vec1(i),  squareSize);
        insertY = ceil(vec1(i)/ squareSize) - 1;

        %In square
        oldVal = im(startX + insertX, startY + insertY);

        %where it is coming from
        swapX = rows(vec2(i));
        swapY = cols(vec2(i));


        %val moving to square
        moveToSquare = im(swapX, swapY);

        %location out of square
        newIm(swapX, swapY) = oldVal;

        %location in square
        newIm(startX + insertX, insertY + startY) = moveToSquare;

    end
end

