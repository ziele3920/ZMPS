function out = GLCM_contrast(in)

GLCM = graycomatrix(in, 'NumLevels', 8, 'offset', [0 1; -1 1; -1 0; -1 -1]);
Props = graycoprops(GLCM, 'Contrast');
out = nanmax(Props.Contrast);