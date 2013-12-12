function [ outputImage ] = blendWithMask( imga, imgb, contrastOffset, levels, squareSize )


imgb = imgb + (contrastOffset/255.0);

limga = genPyr(imga,'lap',levels); % Laplacian pyramid 1

limgb = genPyr(imgb,'lap',levels); % Laplacian pyramid 2



%square Mask

[h, w, d] = size(limga{1});

centerH = floor(h/2);
centerW = floor(w/2);

maska = ones(size(limga{1}));
maska(centerH-squareSize: centerH+squareSize, centerW-squareSize: centerW+squareSize, :) = 0;
maskb = 1-maska;

blurh = fspecial('gauss',15,7); % feather the border. Size then  sigma
%maska = imfilter(maska,blurh,'replicate');
%maskb = imfilter(maskb,blurh,'replicate');
%maska = imfilter(maska,blurh,'replicate');
%maskb = imfilter(maskb,blurh,'replicate');
%maska = imfilter(maska,blurh,'replicate');
%5maskb = imfilter(maskb,blurh,'replicate');
%imshow(maskb);

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