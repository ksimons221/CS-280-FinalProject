function [ pyramid ] = simpleTexturePyramid( image, levels )

    pyramid = cell(1,levels);

    gPyramid = genPyr(image,'gauss',levels);
    lPyramid = genPyr(image,'lap',levels);

    for i = 1:levels-1
        pyramid{i} = lPyramid{i} + impyramid(gPyramid{i+1}, 'expand');
    end

    pyramid{levels} = gPyramid{levels};

end

