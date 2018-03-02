close all; clc; clear;

[A, B] = xlsread('MIAS\list.xlsx');
%normal conditions
% assume Fatty tissue: 2nd cilumn = 'F'
N = length(B);
ind_normals = zeros(N,1);
ind_F = zeros(N,1);

for ii = 1:N
    ind_normals(ii) = strcmp(B{ii,3}, 'NORM');
    ind_F(ii) = strcmp(B{ii,2}, 'F');
end

ind_normals = ind_normals .* ind_F;

% Abnormal conditions
% Assume 'CIRC' conditions and benign cancer ('B')

N = length(B);
ind_abnormals = zeros(N,1);
ind_B = zeros(N,1);

for ii = 1:N
    ind_abnormals(ii) = strcmp(B{ii,3}, 'CIRC');
    ind_B(ii) = strcmp(B{ii,4}, 'B');
end

ind_abnormals = ind_abnormals .* ind_B .* ind_F;

% display abnornal images

ind = find(ind_abnormals==1);

for ii = 1:length(ind)
   fileName = [B{ind(ii),1} '.pgm'];
   I = imread(['MIAS\' fileName]);
   imshow(I);
   hold on;
   x0 = A(ind(ii), 1);
   y0 = A(ind(ii), 2);
   r = A(ind(ii), 3);
   if ~isnan(x0)
       plot(x0, 1024-y0, 'rx');
       viscircles([x0, 1024-y0], r);
   end
   title(fileName)
   hold off;
  
   pause
end

 figure; imhist(I);
 % naiwna segmentacja na dwie klasy
 BW = im2bw(I);
 figure; imshow(BW);

 % segmentacja na k klas 
 k = 3;
 treshold = multithresh(I, k-1);
 I3 = imquantize(I, treshold);
 figure; imshow(I3, []);
 
 %se = offsetstrel('ball',5,5);
 %erodedI = imerode(originalI,se);
 %figure; imshow(erodedI, []);
 
 %pomys³ 1
 s = regionprops(I3, 'BoundingBox');
 stats = cat(1, s.BoundingBox);
 Ic1 = imcrop(I3, stats(2,:));
 figure; imshow(Ic1, []);
 
 %pomys³ 2
 BW2 = I3 == 2;
 pc = sum(BW2);
 ind = find(pc>5); indcs = ind(1); indce=ind(end);
 pr = sum(BW2');
 ind = find(pr>5); indrs = ind(1); indre=ind(end);
 rect = [indcs indrs indce-indcs indre-indrs];
 Ic2 = imcrop(I3, rect);
 figure; imshow(Ic2, []);
 
 %pomys³ 3
 [y, x] = find(I3 == 2);
 xmin = min(x);
 ymin = min(y);
 xmax = max(x);
 ymax = max(y);
 
 IC = imcrop(I3, [xmin ymin xmax-xmin ymax-ymin]);
 figure; imshow(IC, []);
 
 imageSegmenter(I)
 
