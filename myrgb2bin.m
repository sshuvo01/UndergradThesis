function [ bin ] = myrgb2bin( rgbName )
    rgb = imread(rgbName);
    gray = rgb2gray(rgb);
    bin = imbinarize(gray, 'adaptive', 'ForegroundPolarity', 'dark');
end

