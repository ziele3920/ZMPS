close all; clear; clc;

[T, Resp, BPL, ECG] = get_AD_file;

% interpolate to 200Hz

fs = 200;
t = 0:1/fs:max(T);
S = interp1(T, ECG, t);

% detrend and standardise
s = detrend(S);
s=s./max(abs(s));

% low pas filter
b = [1 0 0 0 0 0 -2 0 0 0 0 0 1];
a = [1 -2 1];
s1 = filter(b, a, s);
s1 = detrend(s1);
s1=s1./max(abs(s1));

%high pass filter
b2 = zeros(1, 33);
b2(1) = -1/32; b2(17) = 1; b2(18) = -1; b2(33) = 1/32;
a = [1 -1];
s2 = filter(b2, a, s1);
s2 = detrend(s2);
s2=s2./max(abs(s2));

%derivative filter

b3 = [0.2 0.1 -0.1 -0.2];
a3 = 1;
d = filter(b3, a3, s2);
d = detrend(d);
d=d./max(abs(d));

maxPlotT = 3;
figure; 
subplot(211);
plot(t,s), hold on; xlim([0 maxPlotT]);
plot(t, s1, 'r'); plot(t, s2, 'g'); grid on;
subplot(212);
plot(t, d); xlim([0 maxPlotT]); grid on;

