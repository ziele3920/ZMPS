close all; clear; clc;

N = 10^7;
x = randn(N,1);
%widmowa g�sto�� mocy
pwelch(x, hanning(256), 128, 256);

%[Sxx, F] = pwelch(x, window, noverlap, nfft, fs);
