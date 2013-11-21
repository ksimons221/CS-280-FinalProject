clear all; clc; close all;

apple =  imread('apple.jpg');
orange =  imread('orange.jpg');

mask = imread('mask512.jpg');

d = 6;

%RED
redApple = apple(:,:,1);
redAppleGPyramid = createGaussianPyramid(redApple, d);
[ redAppleLPyramid ] = createLaplacianPyramid( redAppleGPyramid );

redOrange = orange(:,:,1);
redOrangeGPyramid = createGaussianPyramid(redOrange, d);
[ redOrangeLPyramid ] = createLaplacianPyramid( redOrangeGPyramid );

redMask = mask(:,:,1);
redMaskGPyramid = createGaussianPyramid(redMask, d);

[ blendedPyramidR ] = blend(redOrangeLPyramid, redAppleLPyramid, redMaskGPyramid );

[ finalImageR ] = collapsedPyramid( blendedPyramidR );

%GREEN
greenApple = apple(:,:,2);
greenAppleGPyramid = createGaussianPyramid(greenApple, d);
[ greenAppleLPyramid ] = createLaplacianPyramid( greenAppleGPyramid );

greenOrange = orange(:,:,2);
greenOrangeGPyramid = createGaussianPyramid(greenOrange, d);
[ greenOrangeLPyramid ] = createLaplacianPyramid( greenOrangeGPyramid );

greenMask = mask(:,:,2);
greenMaskGPyramid = createGaussianPyramid(greenMask, d);

[ blendedPyramidG ] = blend(greenOrangeLPyramid, greenAppleLPyramid, greenMaskGPyramid );

[ finalImageG ] = collapsedPyramid( blendedPyramidG );


%BLUE
blueApple = apple(:,:,3);
blueAppleGPyramid = createGaussianPyramid(blueApple, d);
[ blueAppleLPyramid ] = createLaplacianPyramid( blueAppleGPyramid );

blueOrange = orange(:,:,3);
blueOrangeGPyramid = createGaussianPyramid(blueOrange, d);
[ blueOrangeLPyramid ] = createLaplacianPyramid( blueOrangeGPyramid );

blueMask = mask(:,:,3);
blueMaskGPyramid = createGaussianPyramid(blueMask, d);

[ blendedPyramidB ] = blend(blueOrangeLPyramid, blueAppleLPyramid, blueMaskGPyramid );

[ finalImageB ] = collapsedPyramid( blendedPyramidB );

%COMBINE

newImage = cat(3,finalImageR, finalImageG);
newImage = cat(3,newImage, finalImageB);

imshow(newImage);