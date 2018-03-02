close all; clear; clc;

%geting silgnals feom ADInstruments
fs=100;
[T, Resp, BPL, ECG] = get_AD_file;

figure; 
subplot(311);
plot(T, Resp);
grid on;
xlabel('Time[s]');
ylabel('Amplitude {\mu}V');
title('Respiration');

subplot(312);
plot(T, BPL);
grid on;
xlabel('Time[s]');
ylabel('Amplitude {\mu}V');
title('Blood Pulse');
xlim([0 3]);

subplot(313);
plot(T, ECG);
grid on;
xlabel('Time[s]');
ylabel('Amplitude {\mu}V');
title('Electrocardiogram');
xlim([0 3]);
%oceniæ jitter - "szum próbkowania" :] 
%figure; plot(diff(T)); ylim([0 0.02]);
%[qrs_amp_raw,qrs_i_raw,delay] = pan_tompkin(ECG, 100, 1); 
BPLdetrended = detrend(BPL);
BPLnorm = BPLdetrended/max(abs(BPLdetrended));
ECGdetrended = detrend(ECG);
ECGnorm = ECGdetrended/max(abs(ECGdetrended));
[Rxy, LAGS] = xcorr(BPLnorm, ECGnorm);
figure; plot(LAGS, Rxy); grid on;
xlabel('{\tau} [s]'); ylabel('cross-correlation function');
[~,ind] = max(abs(Rxy));
delay = LAGS(ind)/fs;
title(['Delay  = ' num2str(delay) ' [s]']);

%coherence analysys
maxXlim = 50;
X = BPLnorm;
Y = ECGnorm;
nfft = 512;
noverlap = 256;



[Pxx, fx] = pwelch(X, hamming(nfft), noverlap, [], fs);
figure; subplot(221); plot(fx, Pxx); xlim([0 maxXlim]); grid on;
title('BPL signal autocorelation');

[Pyy, fy] = pwelch(Y, hamming(nfft), noverlap, [], fs);
subplot(222); plot(fy, Pyy); xlim([0 maxXlim]); grid on;
title('ECG signal autocorelation');

[Pxy, fxy] = cpsd(X, Y, hamming(nfft), noverlap, [], fs);
subplot(223); plot(fxy, abs(Pxy)); xlim([0 maxXlim]); grid on;
title('BPL andECG signal cross corelation');

[Cxy,fc] = mscohere(X,Y,hamming(nfft), noverlap,[],fs);
subplot(224); plot(fc, Cxy); xlim([0 maxXlim]); grid on;
title('Coross power spectral density');

%system identification
Hf = Pxy./(Pxx + eps);
figure; subplot(211); plot(fx, abs(Hf)); grid on; xlim([0 maxXlim]);
title('identified stochastic signal');

L = length(X);
fftX = fft(X.*hamming(L));
fftY = fft(Y.*hamming(L));
H1 = fftX./(fftY+eps);
fline = linspace(0, fs, L);
subplot(212); plot(fline(1:floor(L/2)), abs(H1(1:floor(L/2)))); grid on;
title('identified deterministic signal');

