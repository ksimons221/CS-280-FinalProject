function [ lap ] = laplacianPyramid( img, level )
%GENPYR generate Gaussian or Laplacian pyramid
%   PYR = GENPYR(A,TYPE,LEVEL) A is the input image, 
%	can be gray or rgb, will be forced to double. 
%	TYPE can be 'gauss' or 'laplace'.
%	PYR is a 1*LEVEL cell array.
% Yan Ke @ THUEE, xjed09@gmail.com

pyr = cell(1,level);
lap = cell(1,level);
pyr{1} = im2double(img);
for p = 2:level
	pyr{p} =  impyramid(pyr{p-1}, 'reduce'); %pyr_reduce(pyr{p-1});
end

for p = level-1:-1:1 % adjust the image size
	osz = size(pyr{p+1})*2-1;
	pyr{p} = pyr{p}(1:osz(1),1:osz(2),:);
end

lap{level} = pyr{level};
for i = (level-1):-1:1
    lap{i} = pyr{i} - impyramid(pyr{i+1}, 'expand');
end

for i = 1:level
    minVal = min(min(lap{i}));
    if minVal < 0
        lap{i} = lap{i} - minVal;
    end
end

end

