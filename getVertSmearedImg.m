function [ outputBinImg ] = getVertSmearedImg( inputBinImg, threshold )
    [rowN, colN] = size(inputBinImg);
    outputBinImg = inputBinImg;
    
    for j = 1:colN
        colImg = inputBinImg(:, j);
        cc = bwconncomp(colImg, 4);
        leng = cc.NumObjects;
        outputCol = colImg;
        
        for ii = 2:leng-1
            if length(cc.PixelIdxList{ii}) <= threshold
                outputCol(cc.PixelIdxList{ii}) = 0;
            end %end of if
        end %end of for
    
    outputBinImg(:, j) = outputCol;
    end %end of for
end %end of function

