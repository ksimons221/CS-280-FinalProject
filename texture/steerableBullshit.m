clc;
clf;
clear;
im = imread('texture1.jpg');
filter_bank = H4(1);


im_g = double(rgb2gray(im));
gau = fspecial('gaussian');

diff = filter_bank(:,:,1) - filter_bank(:,:,5);

low_pass = conv2(im_g, gau, 'same');
high_pass = double(im_g) - low_pass;

im1 = conv2(im_g, filter_bank(:,:,1), 'same');
im2 = conv2(im_g, filter_bank(:,:,2), 'same');

im3 = conv2(im_g, filter_bank(:,:,3), 'same');
im4 = conv2(im_g, filter_bank(:,:,4), 'same');


high1 = low_pass -im1;
high2 = low_pass -im2;

high3 = low_pass -im4;
high4 = low_pass -im3;
alpha = 1000;


im11 = conv2(im1, filter_bank(:,:,5), 'same');
im22 = conv2(im2, filter_bank(:,:,6), 'same');
im33 = conv2(im3, filter_bank(:,:,7), 'same');
im44 = conv2(im4, filter_bank(:,:,8), 'same');

sum_im = (im11+im22+im33+im44 + alpha*(high1 + high2+high3+high4))./8;
sum2 = (im11+im22+im33+im44)./4;
imagesc(sum_im);

keyboard;