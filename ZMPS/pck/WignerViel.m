close all; clear all; clc;

x = atoms(256, [64, 0.15, 32 1], false); %N, [t0, f0, s0 A0], disp
y = atoms(256, [192 0.35 16 1.25], false);

%z = atoms(256); tryb interaktywny
%tfrwv(x); %reprezentacja wiegnera-viella
%tfrstft(x); %short time fourier transform
[Sxx, T, F] = tfrwv(x); %zapis reprezenacji do zmiennej
Syy = tfrwv(y);
figure(1); imagesc(T, F, Sxx + Syy); colorbar
set(gca, 'Ydir', 'normal'); %kierunek osi F

z = x+y;
Szz = tfrwv(z);
figure(2); imagesc(Szz); colorbar
set(gca, 'Ydir', 'normal')
min(Szz(:))

filtr2D = fspecial('gaussian', [7 7], 1.8);
Szzc = conv2(Szz, filtr2D, 'same');

figure(3); imagesc(Szzc); colorbar
set(gca, 'Ydir', 'normal')
min(Szzc(:))