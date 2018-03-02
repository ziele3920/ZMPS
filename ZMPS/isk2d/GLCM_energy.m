function out = GLCM_energy(in)

GLCM = graycomatrix(in, 'NumLevels', 8, 'offset', [0 1; -1 1; -1 0; -1 -1]);
Props = graycoprops(GLCM, 'Energy');
out = nanmax(Props.Energy);