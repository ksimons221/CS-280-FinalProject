function [ out ] = upsampleImage( im, factor )
for i = 1:size(im,3)
    temp = upsample(im(:,:,i), factor);
    out(:,:,i) = upsample(temp', factor);
end
end

