imgBin = mygray2bin('Lines\L001.bmp');
imgBin = getSkewCorrectedImg(imgBin);
imtool(imgBin);
testBin = imgBin;
%getting average component height
imgBinInv = ~imgBin;

states = regionprops(imgBinInv, 'BoundingBox');
[y1, y2, x1, x2] = BoundingBoxFromRegionprops(states, 1);

imgBinInv = imgBinInv(x1:x2, y1:y2); %keep the image inside the bounding box
imgBin = imgBin(x1:x2, y1:y2);

cc = bwconncomp(imgBinInv);
stats = regionprops(cc,'BoundingBox');  

height = 0;
heightVector = zeros(1, length(stats));

for n = 1 : length(stats)    
     thisBB = stats(n).BoundingBox;
     height = height + thisBB(4);
     heightVector(n) = thisBB(4);
end 

heightVector = sort(heightVector);
avg_h =  heightVector( floor(length(stats)*.65) ) ;

%avg_h = round(height/length(stats));
%avg_h = mean(heightVector);
%%%
avg_w = round(avg_h*0.45);
%avg_w = 8;
%avg_w = round(yo(testBin));

imgBinInv = bBoxImg(imgBinInv);

a = 0.2;
T = maketform('affine', [1 0 0; a 1 0; 0 0 1] );
imgBinSlntInv1 = imtransform(imgBinInv,T);
T = maketform('affine', [1 0 0; -a 1 0; 0 0 1] );
imgBinSlntInv2 = imtransform(imgBinInv,T);

finalImgInv = (imgBinSlntInv1 | imgBinSlntInv2);
imtool(~finalImgInv);
[~, rCol] = size(finalImgInv);
[~, oCol] = size(imgBin);
padS = round(abs(rCol - oCol) / 2);
imgBin = ~padarray(~imgBin, [0 padS], 'both');
%imtool(finalImgInv);
%flippedInv = flip(finalImgInv); %flip vertically
%finalImgInv = finalImgInv | flippedInv;
%imtool(~finalImgInv);

VSImg = getVertSmearedImg(~finalImgInv, avg_h);
imtool(VSImg);
%imtool(finalImg1);
%vert1 = getVerticalHistogram(finalImg);
%imtool(vert1);
HSImg = getHorSmearedImg(~finalImgInv, avg_w);
imtool(HSImg);
%imtool(finalImg);
%vert2 = getVerticalHistogram(finalImg);
%imtool(vert2);
%verticalProfile = sum(finalImgInv);

%WDmatrix = wig2(verticalProfile);

avg_w = round(avg_w * 1.5);

%%%make the height and width odd
if mod(avg_h, 2) == 0
    avg_h = avg_h + 1;
end
if mod(avg_w, 2) == 0
    avg_w = avg_w + 1;
end

VSHist = sum(~VSImg);
HSHist = sum(~HSImg);

widthPadSize = floor(avg_w/2);
VSHist = padarray(VSHist, [0 widthPadSize]);
HSHist = padarray(HSHist, [0 widthPadSize]);
imgBin = padarray(imgBin, [0 widthPadSize], 'both'); % pad the image

[imgRow, imgCol] = size(finalImgInv);
beginCol = widthPadSize + 1; %calc begins here
endCol = imgCol - widthPadSize; %where the calculation in histogram ends

%calculate, window size = avg_h * avg_w
%windowMultiplier = zeros(1, avg_w);
firstHalf = widthPadSize:-1:1;
secondHalf = 1:widthPadSize;

windowMultiplier = [firstHalf 0 secondHalf];
windowMultiplier = windowMultiplier + 1;%3 2 1 2 3... like this

%maxSum = sum(windowMultiplier*avg_h);
maxSum = sum(windowMultiplier*avg_h);

WSEG = readfis('WSEG');
[histRow, histCol] = size(VSHist);
chances = ones(1, histCol)*-1;

for c = beginCol:endCol
    VSVec = VSHist(c-widthPadSize:c+widthPadSize);
    HSVec = HSHist(c-widthPadSize:c+widthPadSize);
    
    VSVec(VSVec > avg_h) = avg_h; %limit within the window
    HSVec(HSVec > avg_h) = avg_h;
    
    VSSum = sum( VSVec.*windowMultiplier);
    HSSum = sum( HSVec.*windowMultiplier);
    %features for fuzzy inference system
    feature1 = VSSum/maxSum;
    feature2 = HSSum/maxSum;
    %feature1 
    %feature2
    chances(c) = evalfis([feature1 feature2], WSEG);
end %end of for

threshold = -0.5;
maxValue = max(chances);

finalImg = ~finalImgInv;
[r, c] = size(imgBin);

mask = true(r, c);
for ii = 1:histCol
    if chances(ii) >= maxValue + threshold
        mask(:,ii) = 0;
    end %end of if
end %end of for

imgRgb = mybw2rgb(imgBin);
testRgb = getPaintedImg(imgRgb, mask, [255 0 0]);
imtool(testRgb);



