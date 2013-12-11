function [xIndexNoisy, yIndexNoisy, xIndexCalm, yIndexCalm ] = noisyPatchFinder(im, squareSize )
% Will return the x and y indes of the least noisy, and the most noisy
% patch of squareSize in the image.

[h, w] = size(im);

mostNoise = -inf;
leastNoise = inf;

for i = 1: h + 1 -squareSize
    for j = 1: w + 1 -squareSize
        patch = im(i: i+ squareSize - 1, j: j+ squareSize - 1);
        [ val ] = calculateNoiseInPatch( patch );
        
        if val > mostNoise
            mostNoise = val;
            xIndexNoisy = i;
            yIndexNoisy = j;
        end
        if val < leastNoise
            leastNoise = val;
            xIndexCalm = i;
            yIndexCalm = j;
        end
        
    end
end

end

