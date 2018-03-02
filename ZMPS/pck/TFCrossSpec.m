function [ Sx, Sy ] = TFCrossSpec( x, y, fftlen)
% Assuming x is longer than fftlen:
overlap = fftlen/2; % 50% overlap
win = hanning(fftlen);
X = buffer(x,fftlen,overlap,'nodelay');  % Matrix of overlapping STIs
numSTIs = size(X,2);
winX = X.*win(:,ones(1,numSTIs)); % Time-domain windowed STIs
Sx = fft(winX,fftlen,1)/fftlen;  % Double-Sided Complex Spectrum Matrix
SdBx = 20*log10(2*abs(Sx(1:fftlen/2+1,:)));  % Log Scale Single-Sided Real Spectrum Matrix

Y = buffer(y,fftlen,overlap,'nodelay');  % Matrix of overlapping STIs
numSTIs = size(Y,2);
winY = Y.*win(:,ones(1,numSTIs)); % Time-domain windowed STIs
Sy = fft(winY,fftlen,1)/fftlen;  % Double-Sided Complex Spectrum Matrix
SdBy = 20*log10(2*abs(Sy(1:fftlen/2+1,:)));  % Log Scale Single-Sided Real Spectrum Matrix
end

