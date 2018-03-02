close all; clear; clc;
%[Sxx, F] = pwelch(x, window, noverlap, nfft, fs);
%[Sxy, F] = cpsd(x, y, ---/---/---); cross power spectral density
%[Cxy, F] = mscohere(x, y, ---/---/---);
%phase_xy = arg(Sxy);

N = 1000;
fs = 1000;
t = (0 : N-1) / fs;
amp = 0.02;

x = cos(2*pi*100*t) + 0.1 * randn(size(t));% + sin(2*pi*200*t) + 0.1 * randn(size(t));
y = cos(2*pi*100*t - pi/4) + cos(2*pi*60*t);%0.5*cos(2*pi*100*t - pi/4) + amp*sin(2*pi*200*t + pi/2) + 0.1*randn(size(t));

[Sxy, F] = cpsd(x,y, [],[],[], fs);
Phase_xy = angle(Sxy);
subplot(211);
plot(F, Phase_xy * 180/pi); ylabel('phase [degrees]'); grid;

[Sxx, Fx] = pwelch(x, [], [], [], fs);
[Syy, Fy] = pwelch(y, [], [], [], fs);
[a, b] = TFCrossSpec(x, y, 1024);
Cxy2 = abs(Sxy).^2./(Sxx .* Syy);
Cxy = mscohere(x,y,[],[],[],fs);
subplot(212); plot(F, Cxy); ylabel('MS-Coherence'); grid; hold on;
plot(F, Cxy2, 'rx');
figure; 
subplot(211); imagesc(abs(a));
subplot(212); imagesc(abs(b));

[S0, T, F]= tfrspwv(y');
%[S0, T, F]= wv(y);
%[Sxy, F] = cpsd(S0,S0, [],[],[], fs);
figure; imagesc(T, F, abs(S0)); colorbar
set(gca, 'Ydir', 'normal'); %kierunek osi F

Cxytf = abs(Sxy).^2./(Sxx .* Syy);
%subplot(212); surf(abs(b));