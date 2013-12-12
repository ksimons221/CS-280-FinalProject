function [cdf] = makeCDFTtemp(im)

[h] = myHist2(im);

sum = 0;
cdf = zeros(size(h));
for i=1:length(h)
    sum = h(i) + sum;
    cdf(i) = sum;
end
end

