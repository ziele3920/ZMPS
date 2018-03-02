close all; clear; clc;

I = imread('MIAS\mdb001.pgm');

fun_contrast = @ (struktura_bloku) GLCM_contrast(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_corr = @ (struktura_bloku) GLCM_corr(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_energy = @ (struktura_bloku) GLCM_energy(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_homogenity = @ (struktura_bloku) GLCM_homogenity(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_entropy = @ (struktura_bloku) entropy(struktura_bloku.data)*ones(size(struktura_bloku.data));

J_cont = double(blockproc(I, [32 32], fun_contrast));
J_corr = double(blockproc(I, [32 32], fun_corr));
ind = isnan(J_corr);
J_corr(ind) = 0;

J_ener = double(blockproc(I, [32 32], fun_energy));
J_homo = double(blockproc(I, [32 32], fun_homogenity));

figure; 
subplot(221); imagesc(J_cont); title('GLCM Contrast');
subplot(222); imagesc(J_corr); title('GLCM Correlation');
subplot(223); imagesc(J_ener); title('GLCM Energy');
subplot(224); imagesc(J_homo); title('GLCM Homogenity');

k = 4;
I = double(I);
Id = (I(:)-mean(I(:)))./std(I(:));
Jd_cont = (J_cont(:)-mean(J_cont(:)))./std(J_cont(:));
Jd_corr= (J_corr(:)-mean(J_corr(:)))./std(J_corr(:));
Jd_ener = (J_ener(:)-mean(J_ener(:)))./std(J_ener(:));
Jd_homo = (J_homo(:)-mean(J_homo(:)))./std(J_homo(:));

IDX = kmeans([Id Jd_cont Jd_corr Jd_ener Jd_homo], k);
IDX = reshape(IDX, [1024, 1024]);
figure; imagesc(IDX);
hold on;
plot(535, 1024-425, 'mo');
viscircles([535 1024-425], 197, 'color', [1 0 0]);
