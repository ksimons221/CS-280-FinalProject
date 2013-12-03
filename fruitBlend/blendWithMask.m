function [ outputImage ] = blendWithMask( imga, imgb, contrastOffset, shift, levels )

% size(imga) = size(imgb) %imresize(imga,[size(imgb,1) size(imgb,2)]);

imgb = imgb + (contrastOffset/255.0);

limga = genPyr(imga,'lap',levels); % Laplacian pyramid 1
limgb = genPyr(imgb,'lap',levels); % Laplacian pyramid 2
newSize = size(limga{1}, 1);

v = ceil(newSize/2.0) - shift;

% Create a mask
maska = zeros(size(limga{1}));
maska(:,1:v,:) = 1;
maskb = 1-maska;
blurh = fspecial('gauss',10,4); % feather the border. Size then  sigma
%maska = imfilter(maska,blurh,'replicate');
%maskb = imfilter(maskb,blurh,'replicate');

imshow(maska);

% Done with mask

%creates blended pyramid
blendedPyramid = cell(1,levels); % the blended pyramid
blendedPyramid{1} = limga{1}.*maska + limgb{1}.*maskb;
for p = 2:levels
    maska = impyramid(maska, 'reduce');
    maskb = impyramid(maskb, 'reduce');
	blendedPyramid{p} = limga{p}.*maska + limgb{p}.*maskb;
end


outputImage = collapsePyramid(blendedPyramid);   %%collapse

end