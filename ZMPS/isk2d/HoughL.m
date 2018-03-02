close all; clear; clc;
%liniowa transformata Hough;

I = imread('ul2.jpg');
I = rgb2gray(I);
[BW, th] = edge(I, 'canny', 0.1);
disp(th);
figure; imagesc(BW); colormap gray;

[H, theta, rho] = hough(BW);
figure; imagesc(H); colormap gray

figure; surf(H); shading interp;

%znajdŸ lokalne maksima w macierzy akumulacji H

numpeaks = 20;
peaks = houghpeaks(H, numpeaks, 'Threshold', 0.2*max(H(:)));
lines = houghlines(BW, theta, rho, peaks);

figure; imshow(I);
hold on;
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
hold off;

%ko³owa transformata Hough'a

I = imread('cells.jpg');
I = rgb2gray(I);
radiousRange = [5, 50];

%z wykrywanuiem krawêdzi
BW = edge(I, 'canny');
[centers, radii] = imfindcircles(BW, radiousRange, 'ObjectPolarity', 'dark');
figure; subplot(211); imshow(I); hold on;
viscircles(centers, radii, 'Color', [1 0 0]);

%bez wykrywania krawêdzi
[centers, radii] = imfindcircles(I, radiousRange, 'ObjectPolarity', 'bright');
subplot(212); imshow(I); hold on;
viscircles(centers, radii, 'Color', [1 0 0]);

%najlepsza funkcj¹ do tej pory jest "CircuarHough_Grd.m"

