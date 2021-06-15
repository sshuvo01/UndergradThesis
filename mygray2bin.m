function [ binImg ] = mygray2bin( grayName )
    grayImg = imread(grayName);
    binImg = imbinarize(grayImg, 'adaptive', 'ForegroundPolarity', 'dark');
end

