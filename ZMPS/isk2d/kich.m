close all; clear; clc;

I = imread('MIAS\mdb231.pgm');
figure; imshow(I);

fun_contrast = @ (struktura_bloku) GLCM_contrast(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_corr = @ (struktura_bloku) GLCM_corr(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_energy = @ (struktura_bloku) GLCM_energy(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_homogenity = @ (struktura_bloku) GLCM_homogenity(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_entropy = @ (struktura_bloku) entropy(struktura_bloku.data)*ones(size(struktura_bloku.data));

blockSize = [16 16];

J_cont = double(blockproc(I, blockSize, fun_contrast));
J_corr = double(blockproc(I, blockSize, fun_corr));
ind = isnan(J_corr);
J_corr(ind) = 0;
J_ener = double(blockproc(I, blockSize, fun_energy));
J_homo = double(blockproc(I, blockSize, fun_homogenity));
J_entropy = double(blockproc(I, blockSize, fun_entropy));

figure;imagesc(J_entropy); title('entropy');
hold on;
plot(252, 1024-788, 'mo');

figure; 
subplot(221); imagesc(J_cont); title('GLCM Contrast');
hold on;
plot(603, 1024-538, 'mo');
subplot(222); imagesc(J_corr); title('GLCM Correlation');
hold on;
plot(603, 1024-538, 'mo');
subplot(223); imagesc(J_ener); title('GLCM Energy');
hold on;
plot(603, 1024-538, 'mo');
subplot(224); imagesc(J_homo); title('GLCM Homogenity');
hold on;
plot(603, 1024-538, 'mo');

k = 6;
I = double(I);
Id = (I(:)-mean(I(:)))./std(I(:));
Jd_cont = (J_cont(:)-mean(J_cont(:)))./std(J_cont(:));
Jd_corr= (J_corr(:)-mean(J_corr(:)))./std(J_corr(:));
Jd_ener = (J_ener(:)-mean(J_ener(:)))./std(J_ener(:));
Jd_homo = (J_homo(:)-mean(J_homo(:)))./std(J_homo(:));
Jd_entropy= (J_entropy(:)-mean(J_entropy(:)))./std(J_entropy(:));

IDX = kmeans([Id Jd_cont Jd_corr Jd_ener Jd_homo Jd_entropy], k);
IDX = reshape(IDX, [1024, 1024]);
figure; imagesc(IDX);
hold on;
plot(603, 1024-538, 'mo');
viscircles([603 1024-538], 44, 'color', [1 0 0]);
