function [ im ] = matchTextureLap( noise, texture, numLevelsPyr, iterations )

texturePyramid = genPyr(texture, 'lap', numLevelsPyr);

im = matchHistogram(noise, texture);



for i = 1:iterations
    i
    noiseTexture = genPyr(im, 'lap', numLevelsPyr);
    for j = 1:numLevelsPyr
        toReplace = matchHistogram(noiseTexture{j}, texturePyramid{j});
        
         noiseTexture{j} = toReplace;

        %if j == 5
           %keyboard;
           squareSize = 32/(2^(j-1));
           start = floor(size(toReplace, 2)/2);
           r = max(max(toReplace)) - min(min(toReplace));
           [ bullshit ] = swap( toReplace, r*90/255, r*110/255, squareSize, start - squareSize/2, start- squareSize/2);
            noiseTexture{j} = bullshit;

        %end

    end
    
    %{
    bottom  = synthesis_pyr{5};
    
    bottom(5,5) = 0;
    
    bottom(10, 10) = 1;
    bottom(50, 20) = .2;
    
    bottom(20, 20) = .8;

    synthesis_pyr{5} = bottom;
    %}
    %keyboard;
    im = collapsePyramid(noiseTexture);
    im = matchHistogram(im, texture);
end


end

