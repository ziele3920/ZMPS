clc; close all; clear;
%linear (in parameters) least squares (LS) method 2
load tempRIPI.mat

RI = DANE(:,1);
PI = DANE(:,2);

[x,o] = sort(RI);
y = PI(o);
figure; plot(x,y, '.'); hold on;
xlabel('RI');
ylabel('RI');

Y = y;
N = length(y);
%model 1. liniowy
X = [ones(N,1) x];
Phat = X\Y;
Yhat1 = X*Phat;
MSE1 = mean((Yhat1 - y).^2);

%model 2. II rz
X = [ones(N,1) x x.^2];
Phat = X\Y;
Yhat2 = X*Phat;
MSE2 = mean((Yhat2 - y).^2);

%model 3. III rz
X = [ones(N,1) x x.^2 x.^3];
Phat = X\Y;
Yhat3 = X*Phat;
MSE3 = mean((Yhat2 - y).^2);

%model 4. wyk³adniczy
Y = log(y);
X = [ones(N,1) x];
Phat = X\Y;
Yhat4 = exp(X*Phat);
MSE4 = mean((Y-Yhat4).^2);

disp([MSE1 MSE2 MSE3 MSE4]);
plot(x, Yhat1, 'r');
plot(x, Yhat2, 'g');
plot(x, Yhat3, 'k');
plot(x, Yhat4, 'm');
legend('Raw data', 'Linear', 'quadratic', 'cubic', 'exponential');

Fk1 = 2*2/N;
Fk2 = 2*3/N;
Fk3 = 2*4/N;
Fk4 = 2*2/N;

AIC = [log(MSE1)+Fk1, log(MSE2)+Fk2, log(MSE3)+Fk3, log(MSE4)+Fk4];
disp(AIC);