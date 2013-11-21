function [ laplacianPyramid ] = createLaplacianPyramid( gaussianPyramid )
    d = size(gaussianPyramid,1);
    
    laplacianPyramid  = cell(d, 1);

    for i = 1 : d -1 
        oldPyramid = impyramid(gaussianPyramid{i+1}, 'expand');
        sizeCurrent = size(gaussianPyramid{i},1);
        oldPyramid = [oldPyramid , oldPyramid(1:sizeCurrent-1, sizeCurrent-1)];
        oldPyramid = [oldPyramid  ; oldPyramid(sizeCurrent-1, :)];
        laplacianPyramid{i} = gaussianPyramid{i} -  oldPyramid;%imresize(gaussianPyramid{i+1}, 2);
    end
    laplacianPyramid{d} = gaussianPyramid{d};
    
end

