close all; clc; clear;

%single image feom MIAS database
I = imread('MIAS\mdb231.pgm');
figure; imshow(I);
hold on;
plot(603, 1024-538, 'mo');
viscircles([603 1024-538], 44, 'color', [1 0 0]);


k = 5;
treshold = multithresh(I, k-1);
I3 = imquantize(I, treshold);
Ibw = I3==5;

Ihand = bwareaopen(Ibw, 10000);
Ihand = imfill(Ihand, 'holes');
IhandNeg = imcomplement(Ihand);

figure; subplot(311); imshow(Ihand, []);
subplot(312); imshow(IhandNeg, []);
Iwh = immultiply(Ibw, IhandNeg);

subplot(313); imshow(Iwh, []);
Ifl = bwareaopen(Iwh, 1000);
figure; imshow(Ifl, []);