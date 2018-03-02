function out = GLCM_homogenity(in)

GLCM = graycomatrix(in, 'NumLevels', 8, 'offset', [0 1; -1 1; -1 0; -1 -1]);
Props = graycoprops(GLCM, 'Homogeneity');
out = nanmean(Props.Homogeneity);