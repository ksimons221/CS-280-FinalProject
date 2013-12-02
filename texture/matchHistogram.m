function [ out_im ] = matchHistogram( im1, im2 )
% im1 should be noise and im2 should be the texture
out_im = zeros(size(im1));

im1_cdf = makeCDF(im1);
im2_cdf = makeCDF(im2);

inv_im2_cdf = makeInvCDF(im2_cdf);

[rows, cols] = size(out_im);

for i = 1:rows
    for j = 1:cols
        out_im(i,j) = 0; %lookup(inv_im2_cdf, im1_cdf(im1(i,j)))
    end
end

end

function [cdf] = makeCDF(im)
im = reshape(im, 1, []);
im = im./(size(im, 1)*size(im, 2));
h = hist(im);
sum = 0;
cdf = zeros(size(h));
for i=1:length(h)
    sum = h(i) + sum;
    cdf(i) = sum;
end
end

function [inv_cdf] = makeInvCDF(cdf)

end