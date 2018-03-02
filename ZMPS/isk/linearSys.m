clc; close all; clear;
%linear (in parameters) least squares (LS) method

N = 100;
x = linspace(0,5,N);
y = 5+8*x + 10* randn(size(x));
figure; 
plot(x,y, '.'); hold on;
Y = y';
X = [ones(N,1), x'];
%Phat = (X'*X)^(-1)*X'*Y;
Phat = X\Y;
Yhat = X*Phat;
RMS = sqrt(mean((Y-Yhat).^2));
plot(x, Yhat, 'r');
title(['I rz rms = ' num2str(RMS)]);

%investigate the [p;ynomial model order]

Q=13;
Y=y';
X = ones(N,1);
    for q = 1:Q
       X = [X (x').^q];
       Phat = X\Y;
       Yhat = X*Phat;
       MSE(q) = mean((Y-Yhat).^2);
       Fk(q) = 2*(q+1)/N;
    end;

plot(x, Yhat, 'r'); hold off;
figure; subplot(311); plot(1:Q, MSE); title('MSE');
subplot(312); plot(1:Q, Fk); title('penatly function');
AIC = log(MSE) + Fk;
subplot(313); plot(1:Q, AIC); title('Akaike Information Criterion');





