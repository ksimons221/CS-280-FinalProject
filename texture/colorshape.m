function [ im_colorshaped, M, means_d ] = colorshape( im )
[x, y, z] = size(im);
h = x*y;
D = reshape(im, h, 3);
means_d = mean(D);
D_norm = double(D) - [ones(h,1)*means_d(1) ,ones(h,1)*means_d(2), ones(h,1)*means_d(3)];
D_norm = D_norm';
C= D_norm*D_norm';

[V, S, U] = svd(C);
S_root = sqrt(S);
inv_S = inv(S_root);

M = (inv_S)*U';
im_colorshaped = M*D_norm;


end

