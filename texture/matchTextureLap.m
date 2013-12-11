function [ im ] = matchTextureLap( noise, texture, numLevelsPyr, iterations )
im = matchHistogram(noise, texture);
analysis_pyr = genPyr(texture, 'lap', numLevelsPyr);

for i = 1:iterations
    i
    synthesis_pyr = genPyr(im, 'lap', numLevelsPyr);
    for j = 1:numLevelsPyr
        toReplace = matchHistogram(synthesis_pyr{j}, analysis_pyr{j});
        synthesis_pyr{j} = toReplace;
    end
        
    bottom  = synthesis_pyr{5};
    
    bottom(5,5) = 0;
    
    bottom(10, 10) = 1;
    bottom(50, 20) = .2;
    
    bottom(20, 20) = .8;

    synthesis_pyr{5} = bottom;
    
    im = collapsePyramid(synthesis_pyr);
    im = matchHistogram(im, texture);
end


end

