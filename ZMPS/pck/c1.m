close all; clc; clear;

N = 512;
%N, f0, f1
%generuje sygna� alalityczny (transformata Hilberta w cz�ci urojonej
x = fmlin(N, 0.05, 0.35) + fmlin(N, 0.1, 0.4);
%plot(real(x))
tfrstft(x, 1:N, 4*N, hamming(odd(70))); % hamming(odd(N/8)));