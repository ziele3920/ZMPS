close all; clear; clc;

N = 500;
fs = 500;
t = (0 : N-1) / fs;
amp = 0.1;

x = cos(2*pi*50*t) + 0.1 * randn(size(t));% + sin(2*pi*200*t) + 0.1 * randn(size(t));
y = cos(2*pi*50*t - pi/4) + cos(2*pi*30*t);%0.5*cos(2*pi*100*t - pi/4) + amp*sin(2*pi*200*t + pi/2) + 0.1*randn(size(t));

%time domain
[Sxy, F] = cpsd(x,y, [],[],[], fs);
[Sxx, Fx] = pwelch(x, [], [], [], fs);
[Syy, Fy] = pwelch(y, [], [], [], fs);

Cxy = abs(Sxy).^2./(Sxx .* Syy);
subplot(212); plot(F, Cxy); ylabel('Coherence'); xlabel('frequency [Hz]'); grid;

Phase_xy = angle(Sxy);
subplot(211);
plot(F, Phase_xy * 180/pi); ylabel('phase [degrees]'); xlabel('frequency [Hz]'); grid;

%time-frequency domain
[Sxytf, Ttf, Ftf]= tfrspwv([x', y']);
Sxytf=Sxytf./max(abs(Sxytf(:)));
Sxxtf= tfrspwv(x');
Sxxtf=Sxxtf./max(abs(Sxxtf(:)));
Syytf= tfrspwv(y');
Syytf=Syytf./max(abs(Syytf(:)));
Cxytf = abs(Sxytf).^2./(Sxxtf .* Syytf);
%Cxytf = histeq(Cxytf);
%Cxytf = Cxytf .* (abs(Cxytf) < 1000);
figure; imagesc(Ttf, Ftf, abs(Sxytf)); colorbar
set(gca, 'Ydir', 'normal'); 
figure; imagesc(Ttf, Ftf, abs(Sxxtf)); colorbar
set(gca, 'Ydir', 'normal'); 
figure; imagesc(Ttf, Ftf, abs(Syytf)); colorbar
set(gca, 'Ydir', 'normal'); 
figure; imagesc(Ttf, Ftf, abs(Cxytf)); colorbar
set(gca, 'Ydir', 'normal'); 

