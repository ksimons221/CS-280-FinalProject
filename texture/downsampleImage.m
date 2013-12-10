function [ out ] = downsampleImage( im, factor )
out = im(1:factor:end, 1:factor:end, :);
end