function [ finalImage ] = collapsedPyramid( lap )

    d = size(lap,1);
        
    for i = 1 : d-1
        index = d - i + 1;
        biggerPIndex = index - 1;
        oldPyramid = impyramid(lap{index}, 'expand');
        sizeCurrent = size(lap{index-1},1);
        oldPyramid = [oldPyramid , oldPyramid(1:sizeCurrent-1, sizeCurrent-1)];
        oldPyramid = [oldPyramid  ; oldPyramid(sizeCurrent-1, :)];
        lap{biggerPIndex} = lap{biggerPIndex} +  oldPyramid;%imresize(gaussianPyramid{i+1}, 2);
    end
    
    finalImage = lap{1};


end

