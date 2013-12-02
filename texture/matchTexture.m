function [ im ] = matchTexture( noise, texture, numLevelsPyr, iterations )

im = matchHistogram(noise, texture);
analysis_pyr = genPyr(texture, 'laplace', numLevelsPyr);

for i = 1:iterations
    synthesisPyr = genPyr(im, 'laplace', numLevelsPyr);
    for j = 1:numLevelsPyr
        matchHistogram(,);
        
    end
    im = collapsePyramid(synthesisPyr);
    im = matchHistogram(im, texture);
end


end

