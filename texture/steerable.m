smallTexture = imread('texture1.jpg');
allFilters = makeLMfilters();

I = rgb2gray(smallTexture);


firstIm = conv2(I, allFilters(:,:,1), 'valid');


%imagesc(firstIm);

imagesc(allFilters(:,:,30));

