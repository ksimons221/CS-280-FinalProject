function [ out ] = upsampleImage( im, factor )
temp = upsample(im, factor);
out = upsample(temp', factor);
end

