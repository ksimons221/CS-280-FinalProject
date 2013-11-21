clear all; clc; close all;

apple =  imread('apple.jpg');
orange =  imread('orange.jpg');

mask = imread('mask512.jpg');
mask = mask(:,1:256,:);

appleMask = apple;
appleMask(:,257:512,:) = mask;

orangeMask = orange;
orangeMask(:,1:256,:) = mask;

