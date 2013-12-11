function [ ] = doublePlotHistogram( im, startX, startY, squareSize )

    clf;
    [bigHisto] = myHist2(im);
    
    subImage = im(startX: startX+squareSize, startY: startY+squareSize);
    
    [smallHisto] = myHist2(subImage);
    
    plot(bigHisto);
    
    hold on
    
    plot(smallHisto, 'r');
    
    hold off

end

