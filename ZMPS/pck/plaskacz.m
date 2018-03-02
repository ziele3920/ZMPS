close all; clear; clc;

N = 256;
%x = randn(N,1);
%spectrumX = abs(fft(x));
%plot(spectrumX);

iloscPowtorzen = 100000; 
spectrumX = 0;
for i = 1 : iloscPowtorzen
    x=randn(N,1);
    spectrumX = spectrumX + abs(fft(x));
end
spectrumX = spectrumX/iloscPowtorzen;
plot(spectrumX);


