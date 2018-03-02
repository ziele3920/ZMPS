close all; clear; clc;

dane = csvread('data/e[3]_[h]_[55].csv', 1);

abp = detrend(dane(:,4));
fvl = detrend(dane(:,3));
fs = 200;
minX = 0; maxX = 0.3;
window = hanning(100*fs);
noverlap = 50*fs;
nfft = 2^nextpow2(length(window));

[Sxy, F] = cpsd(abp, fvl, window, noverlap, nfft, fs);
Phase_xy = angle(Sxy);
subplot(211); plot(F, Phase_xy * 180/pi); ylabel('phase [degrees]'); grid; xlim([minX maxX]);
Cxy = mscohere(abp,fvl, window, noverlap, nfft,fs);
subplot(212); subplot(212); plot(F, Cxy); ylabel('MS-Coherence'); grid; xlim([minX maxX]);
