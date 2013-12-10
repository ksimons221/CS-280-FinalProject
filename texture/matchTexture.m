function [ im ] = matchTexture( noise, texture, numLevelsPyr, iterations )
im = matchHistogram(noise, texture);
[analysis_pyr, analysis_pind] = build(texture, numLevelsPyr);
[num_pyr , ~] = size(analysis_pind);

for i = 1:iterations
    i
    [synthesis_pyr, synthesis_pind] = build(im, numLevelsPyr);
    
    for j = 1:num_pyr
        synthesis_pyr{j} = matchHistogram(synthesis_pyr{j}, analysis_pyr{j});
        
    end
    
    im = collapse(synthesis_pyr, synthesis_pind);
    im = matchHistogram(im, texture);
end


end


function [myCell, pind] = build(im, numLevelsPyr)
[pyr,pind,~,~] = buildSpyr(im, numLevelsPyr, 'sp1Filters', 'reflect1');
[m, b] = size(pind);
myCell = cell(m,1);
startOfpyr = 0;
for x =1:m
    product = prod(pind(x,:));
    myCell{x} = pyr(startOfpyr+1:(product+startOfpyr));
    startOfpyr = startOfpyr + product;
end

end


function im = collapse(myCell, pind)
[m, b] = size(pind);
pyr = myCell{1}(:);
for x =2:m
    temp = myCell{x};
    pyr = [pyr; temp(:)];
end
im = reconSpyr(pyr, pind, 'sp1Filters');
end
