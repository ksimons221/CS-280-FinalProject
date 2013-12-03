function [ output_args ] = magic( bPyramid, maskAPyramid )

levels = size(bPyramid, 2);

t = bPyramid{levels};
t = rgb2gray(t);
r  = maskAPyramid{levels};
r = rgb2gray(r);

[dx, dy] = findPartialDerivative(t);

keyboard;

end

