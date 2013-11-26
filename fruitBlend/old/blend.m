function [ blendedPyramid ] = blend(lap1, lap2, gaus1 )

    d = size(gaus1,1);
    
    blendedPyramid  = cell(d, 1);

    for i = 1:d
        normalizedGaus = gaus1{i};%./255.0;
        p1 = times(normalizedGaus, lap1{i});
        p2 = times(1 - normalizedGaus, lap2{i});
        blendedPyramid{i} = p1 + p2;
    end
    
end

