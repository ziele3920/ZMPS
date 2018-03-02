clc; close all; clear;
%linear (in parameters) least squares (LS) method 3
% for fitting a circle
I = imread('cell.jpg');
figure; imshow(I);
[x,y,P] = impixel;
hold on;
plot(x,y, 'k*');
Y = [x.^2 + y.^2];
X = [2*x 2*y ones(size(x))];
Phat = X\Y;
x0hat = Phat(1);
y0hat = Phat(2);
Rhat = sqrt(Phat(3) + x0hat^2 + y0hat^2);

viscircles([x0hat y0hat], Rhat, 'Color', 'c');

