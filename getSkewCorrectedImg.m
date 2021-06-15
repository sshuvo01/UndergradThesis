function [ correctedImg, baseCoords ] = getSkewCorrectedImg( skewedImg )
    %skewedImg = binary image, foreground is black
    global originalImg;
    global originalImgRow;
    global originalImgCol;
    global skewCorrectedImg;
    
    backupImg = skewedImg;
    %if 0
    sw1 = strokeWidth(skewedImg);
    se1 = strel('square', sw1);
    skewedImg = imdilate(~skewedImg, se1);
    skewedImg = ~skewedImg;
    %end
    originalImg = skewedImg;
    
    [originalImgRow, originalImgCol] = size(originalImg);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %figure(33), imshow(originalImg);

    baseCoords = GetBaseCoordsFromImg();
    x = zeros(length(baseCoords), 1);
    y = zeros(length(baseCoords), 1);

    for ii = 1:length(baseCoords)
        x(ii) = baseCoords(ii).x;
        y(ii) = baseCoords(ii).y;
    end % end of for

    xrot = zeros(length(baseCoords), 1);
    yrot = zeros(length(baseCoords), 1);

    %rotate these points 90 degree clockwise
    for ii = 1:length(baseCoords)
        p = rotatePoint([x(ii) y(ii)], -90);
        xrot(ii) = p(1);
        yrot(ii) = p(2);
    end % end of for

    x = xrot;
    y = yrot;
    
    fuck = double(x);
    me = double(y);

    p = polyfit(fuck, me,1);
    yCalc1 = polyval(p, fuck);

    leng = length(baseCoords);
    m =    ( (yCalc1(1) - yCalc1(leng)) / (fuck(1) - fuck(leng) ) ) ;

    angleRad = wrapTo2Pi(atan(m));
    angleDeg = rad2deg(angleRad);

    temp = ~backupImg;
    finalImg = imrotate(temp, -angleDeg);
    finalImg = ~finalImg;
    skewCorrectedImg = finalImg;
    %figure (3), imshow(finalImg);
    %%
    correctedImg = finalImg;
end

