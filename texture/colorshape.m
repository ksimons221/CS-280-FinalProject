function [ im_colorshaped ] = colorshape( im )

[x, y, z] = size(im);
h = x*y;
D = reshape(im, h, 3);
means_d = mean(D);
D_norm = double(D) - [ones(h,1)*means_d(1) ,ones(h,1)*means_d(2), ones(h,1)*means_d(3)];
C= D_norm'*D_norm;
[~, ~, D_svd] = svd(C);
for f =1:h
   D_temp = D_norm(f, :);
   new_temp = D_svd*D_temp';
   D_norm(f, :) = new_temp;
end

im_colorshaped = D_norm;
end

