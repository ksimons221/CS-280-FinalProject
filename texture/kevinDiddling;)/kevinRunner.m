
clear all; clc; close all;

smallImage = imread('lab.jpg'); 
smallImageGray = rgb2gray(smallImage);

smallImageGray = imresize(smallImageGray, .5);


noise = rand(380, 380);


pyr = load('pyr.mat');
lapPyr = pyr.pyr;

%lapPyr = genPyr(smallImageGray, 'lap', 5);


base = lapPyr{5};

%[h,w]=size(base);

[ dx, dy ] = findPartialDerivative(base);

[ angles, magnitude ] = findGradient( dx, dy );

[ hog ] = createHOG( angles );
  
%plot(hog);

[ img ] = collapsePyramid( lapPyr );

for p = 1 : length(lapPyr)
    currentLevel = lapPyr{p};
    [h,w]=size(currentLevel);
    for i =1:w
        col = currentLevel(:,i);
        col = sortrows(col);
        currentLevel(:,i) = col;
    end
    lapPyr{p} = currentLevel;
end


[ img2 ] = collapsePyramid( lapPyr );

