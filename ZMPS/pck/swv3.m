close all; clear all; clc;

Data = csvread('sygnaly_Ochotnik40.csv', 1);
fs = 200;

abp = Data(: ,4);
abp = abp(17000:end);

rate = 20;
abp1 = decimate(abp, rate); %downsampling z filtrem antyalisingowym
newFs = fs/rate;

abp1 = hilbert(detrend(abp1));

%tfrwv(abp1, 1:8:length(abp1), 1024);

%tfrspwv(abp1, 1:8:length(abp1), 1024);
tfrzam(abp1, 1:8:length(abp1), 1024);