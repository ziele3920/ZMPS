function HR = estimateHR(abp, fs)

    spectrumAbp = abs(fft(detrend(abp)));
    [~, maxInd] = max(spectrumAbp);
    Nfft = length(abp);
    df = fs/Nfft;
    f = (0:Nfft-1)*df;
    HR = f(maxInd) * 60;
    %plot(f, spectrumAbp);
end

