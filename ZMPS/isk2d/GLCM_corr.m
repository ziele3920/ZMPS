function out = GLCM_corr(in)

GLCM = graycomatrix(in, 'NumLevels', 8, 'offset', [0 1; -1 1; -1 0; -1 -1]);
Props = graycoprops(GLCM, 'Correlation');
out = nanmean(Props.Correlation);