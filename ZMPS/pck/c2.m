close all; clc; clear;

Data = csvread('sygnaly_Ochotnik40.csv', 1);
fs = 200;

abp = Data(: ,4);
abp = abp(16200:end);
estimateHR(abp, fs)
%okienkowanie abp

    winLenInSec = 60;
    winLenInSamp = winLenInSec * fs;
    
    winCount = floor(length(abp)/winLenInSamp);
    HRinTime = zeros(winCount, 1);
    
    for w = 1:winCount
        winBegin = (w-1) * winLenInSamp + 1;
        winEnd = w * winLenInSamp;
        HRinTime(w) = estimateHR(abp(winBegin : winEnd), fs);
    end
    t = 0:1/fs:1/fs*length(abp)-1/fs;
    subplot(311)
    plot(t, abp);
    title('signal')
    xlabel('[s]');
    subplot(312)
    plot(0:winLenInSec:length(HRinTime)*winLenInSec-1, HRinTime);
    title('frequencies')
    xlabel('1/min');
    grid on;
    
    etco2 = Data(:,8);
    subplot(313)
    plot(etco2);
    