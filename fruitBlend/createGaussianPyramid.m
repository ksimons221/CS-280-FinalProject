function [ pyramid ] = createGaussianPyramid( image, levels )

pyramid  = cell(levels, 1);
pyramid{1} = image;
for i = 2:levels
    pyramid{i} = impyramid(pyramid{i-1}, 'reduce');
end

end

