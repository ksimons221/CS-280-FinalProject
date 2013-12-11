function [ val ] = calculateNoiseInPatch( patch )



[h, w] = size(patch);

val = 0;
for i = 2: 2 : h
    row = patch(i,:);
    rowAbove = patch(i-1,:);
    
    rowBelow = patch(i,:);
    if i < h
        rowBelow = patch(i+1,:);
    end
    val = val + sum(abs(row - rowAbove)) + sum(abs(row - rowBelow));
end


for i = 2: 2 : w
    col = patch(:,i);
    colLeft = patch(:,i-1);
    
    colRight = patch(:,i);
    if i < w
        colRight = patch(:,i+1);
    end
    val = val + sum(abs(col - colLeft)) + sum(abs(col - colRight));
end




end


