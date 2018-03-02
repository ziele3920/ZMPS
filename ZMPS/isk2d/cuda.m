close all; clc; clear;

I = imread('MIAS\mdb001.pgm');


fun = @ (struktura_bloku) std2(struktura_bloku.data)^2 * ones(size(struktura_bloku.data));
J = blockproc(I, [32 32], fun);
figure; imagesc(J);