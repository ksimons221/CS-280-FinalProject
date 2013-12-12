function [ im ] = swapPatch( im, firstRow, firstCol, secondRow, secondCol, squareSize )


    temp1 = im(firstRow : firstRow + squareSize - 1, firstCol : firstCol + squareSize - 1);

    temp2 = im(secondRow : secondRow + squareSize - 1, secondCol : secondCol + squareSize - 1);

    im(secondRow : secondRow + squareSize - 1, secondCol : secondCol + squareSize - 1) = temp1;

    im(firstRow : firstRow + squareSize - 1, firstCol : firstCol + squareSize - 1) = temp2;    

end

