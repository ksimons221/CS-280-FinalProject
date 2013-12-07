function [ out_im ] = matchHistogram( im1, im2 )
% im1 should be noise and im2 should be the texture
out_im = zeros(size(im1));
shift = 0;

im1_shifted = im1;
%{
if min(min(im1_shifted)) < 0
    keyboard;
    shift = min(min(im1_shifted));
    im1_shifted = im1_shifted - shift;
end
%}

im2_shifted = im2;
%{
if min(min(im2_shifted)) < 0
    im2_shifted = im2_shifted - min(min(im2_shifted));
end
%}

[im1_cdf, min_val1, bucketSize1] = makeCDF(im1_shifted);
[im2_cdf, min_val2, bucketSize2] = makeCDF(im2_shifted);

[rows, cols] = size(out_im);
for i = 1:rows
    for j = 1:cols
        [bucketIndex] = generatBucketIndex(min_val1, bucketSize1, im1_shifted(i,j));
        
        if bucketIndex < 1 || bucketIndex > 256
            keyboard;
        end
       
        newPercentage = CDFLookup(im1_cdf, bucketIndex);
        newPixelValue = InvCDFLookup(im2_cdf,newPercentage ); 
        
  
        
        
        out_im(i,j) = newPixelValue;
    end
end

end

function [cdf, min_val, bucketSize] = makeCDF(im)
[h, min_val, bucketSize] = myHist(im);
sum = 0;
cdf = zeros(size(h));
for i=1:length(h)
    sum = h(i) + sum;
    cdf(i) = sum;
end
end

function [out] = InvCDFLookup(cdf, value)
value = min(value, max(cdf));
for i = 1:length(cdf)
    if abs(cdf(i) - value) < .000001
        out = i;
        return;
    elseif cdf(i) > value && i == 1
        out = 1; % not sure if this is the right way to handle this edge case
        %keyboard;
        return;
    elseif cdf(i) > value && cdf(i-1) <= value
        out = (value-cdf(i-1))*(1/(cdf(i)-cdf(i-1)))+(i-1);
        return;
    elseif i == length(cdf)
        keyboard;
    end
end
end


function [bucketIndex] = generatBucketIndex(minValue, bucketSize, value)
    temp = (value-minValue)/bucketSize;
    if temp == 256
        bucketIndex = temp;
    else
        bucketIndex = floor(temp) +1;
    end
end

function [out] = CDFLookup(cdf, bucketIndex)
value = bucketIndex;

before = floor(value);
if value == before
    out = cdf(value);
else
    after = ceil(value);
    if before < 0 || after < 0
        keyboard;
    end
    m = cdf(after)-cdf(before);
    out = m*(value - before) + cdf(before);
end
end

function [histo, min_val, bucketSize] = myHist(im)
    im = reshape(im, 1, []);
    histo = zeros(1,256);

    max_val = max(im);
    min_val = min(im);

    bucketSize = (max_val-min_val)/256;

    for i = 1:256
        lower_bound = min_val + (i-1)*bucketSize;
        upper_bound = min_val + i*bucketSize;
        histo(i) = length(find(im >= lower_bound & im < upper_bound)); 
    end
    histo = histo/length(im);
end
