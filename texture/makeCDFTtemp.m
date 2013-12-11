function [cdf, min_val, bucketSize] = makeCDFTtemp(im)

[h, min_val, bucketSize] = myHist2(im);

sum = 0;
cdf = zeros(size(h));
for i=1:length(h)
    sum = h(i) + sum;
    cdf(i) = sum;
end
end

