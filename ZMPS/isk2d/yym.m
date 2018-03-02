close all; clc; clear;

%single image feom MIAS database
I = imread('MIAS\mdb141.pgm');
figure; imshow(I);
hold on;

radiousRange = [5, 10];

%z wykrywanuiem krawêdzi
BW = edge(I, 'canny');
[centers, radii] = imfindcircles(BW, radiousRange, 'ObjectPolarity', 'bright');
figure; subplot(211); imshow(I); hold on;
viscircles(centers, radii, 'Color', [1 0 0]);

%bez wykrywania krawêdzi
[centers, radii] = imfindcircles(I, radiousRange, 'ObjectPolarity', 'bright');
subplot(212); imshow(I); hold on;
viscircles(centers, radii, 'Color', [1 0 0]);