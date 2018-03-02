clc; close all; clear;
%linear (in parameters) least squares (LS) method 3
% for bilinear

load tempRIPI;
RI = DANE(:,1);
PI = DANE(:,2);

[x,o] = sort(RI);
y = PI(o);
h1 = figure; plot(x,y, '.'); hold on;
xlabel('RI');
ylabel('RI');

N = length(x);
SSE = ones(N-3, 1);
for n = 2:N-2 
    x1 = x(1:n);
    y1 = y(1:n);
    p1 = polyfit(x1,y1,1);
    y1hat = polyval(p1, x1);
    SSE1 = sum((y1 - y1hat).^2);
    
    x2 = x(n+1:end);
    y2 = y(n+1:end);
    p2 = polyfit(x2,y2,1);
    y2hat = polyval(p2, x2);
    SSE2 = sum((y2 - y2hat).^2);
    SSE(n-1) = SSE1 + SSE2;
end;

figure; plot(SSE);
[~, minInd] = min(SSE);

x1 = x(1:minInd + 1);
y1 = y(1:minInd + 1);
p1 = polyfit(x1,y1,1);
y1hat = polyval(p1, x1);
    
x2 = x(minInd+2:end);
y2 = y(minInd+2:end);
p2 = polyfit(x2,y2,1);
y2hat = polyval(p2, x2);

figure(h1); hold on;
plot(x1, y1hat, 'r');
plot(x2, y2hat, 'r');