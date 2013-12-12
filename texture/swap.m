function [ newIm, swapIndexes ] = swap( im, valueLow, valueHigh, squareSize, startRow, startCol, moveAmount ) 


    %move amount will be be 0 to move into left and 1 to move into right

    %swapIndexes is numSwaps by 4. Each row is x1, y1, x2, y2
    
    cutOff = floor(size(im,2) / 2);
    
    newIm = im;

    if moveAmount == 1
        [rows, cols, ~] = find(im(:,1:cutOff) >= valueLow & im(:,1:cutOff) <= valueHigh);
    else
       [rows, cols, ~] = find(im(:,cutOff+1:end) >= valueLow & im(:,cutOff+1:end) <= valueHigh);
       cols = cols + cutOff;
    end
    %{
    [rows, cols, ~] = find(im >= valueLow & im <= valueHigh);
    
    numElements = length(rows);

    currentIndex = 1;
    timesIterated = 1;
    keyboard;
    while true
       if timesIterated > numElements
           break;
       end
       if moveAmount == 0
           if col(currentIndex) < cutOff
                cols = removerows(cols,currentIndex);
                rows = removerows(rows,currentIndex);

           end
       elseif moveAmount == 1
            if col(currentIndex) > cutOff
                cols = removerows(cols,currentIndex);
                rows = removerows(rows,currentIndex);
           end
       else
          disp('Error');
       end
       timesIterated = timesIterated + 1;
       
    end
    %}
    
    numElements = length(rows);

    
    s = RandStream('mt19937ar','Seed',0);
    
    vec1 =randperm(s,squareSize^2);

    vec2 =randperm(s, numElements);
    
    per = numElements/(squareSize.^2);

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

