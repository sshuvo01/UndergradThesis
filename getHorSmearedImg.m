function [ outputBinImg ] = getHorSmearedImg( inputBinImg, threshold )
    [rowN, colN] = size(inputBinImg);
    outputBinImg = inputBinImg;
    
    for i = 1:rowN
        rowImg = inputBinImg(i, :);
        cc = bwconncomp(rowImg, 4);
        leng = cc.NumObjects;
        outputRow = rowImg;
        
        for ii = 2:leng-1
            if length(cc.PixelIdxList{ii}) <= threshold
                outputRow(cc.PixelIdxList{ii}) = 0;
            end %end of if
        end %end of for
    
    outputBinImg(i, :) = outputRow;
    end %end of for
    
    
end

