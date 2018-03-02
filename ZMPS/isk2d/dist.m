close all; clc; clear;

%single image feom MIAS database
I = imread('MIAS\mdb010.pgm');
figure; imshow(I);
hold on;

%Otsu
k = 5;
treshold = multithresh(I, k-1);
I1 = imquantize(I, treshold);

%figure; imagesc(I1);

%Segmentacja k-œrednich
Id = double(I(:));
Ind = kmeans(Id, k);
I2 = reshape(Ind, [1024, 1024]);

%figure; imagesc(I2);

%Dodajemy inne cechy
%Odleg³oœci geometryczne o œrdoka obrazu

[X, Y] = meshgrid(-511:512, -511:512);
%figure; subplot(121); surf(X); shading interp
%subplot(122); surf(Y); shading interp

%normalizacja
Id = (Id - mean(Id))/std(Id);
%X = (X(:) - mean(X(:)))/std(X(:));
%Y = (Y(:) - mean(Y(:)))/std(Y(:));
R = sqrt(X.^2+Y.^2);
R = (R(:) - mean(R(:)))/std(R(:));

Ind2 = kmeans([Id, R], k);
I3 = reshape(Ind2, [1024, 1024]);
figure; imagesc(I3);

fun = @ (struktura_bloku) std2(struktura_bloku.data)^2 * ones(size(struktura_bloku.data));
J = blockproc(I, [32 32], fun);
%figure; imagesc(J);

%normalizacja
J = (J(:)-mean(J(:)))/std(J(:));

Ind3 = kmeans([Id, J], k);
I4 = reshape(Ind3, [1024, 1024]);
figure; imagesc(I4) 
hold on;

%plot(535, 1024-425, 'ro');
%viscircles([535 1024-425], 197, 'color', [1 0 0]);

treshold = multithresh(I, k-1);
Io = imquantize(I, treshold);
figure; imshow(Io, []);


