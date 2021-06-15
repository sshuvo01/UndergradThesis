function [ outputRgb ] = getPaintedImg( inputRgb, bwMask, color )
    [row, col] = size(bwMask);
    outputRgb = inputRgb;

    for ii = 1:row
        for jj = 1:col
            if bwMask(ii, jj) == 0 %black
                outputRgb(ii, jj, 1) = color(1);
                outputRgb(ii, jj, 2) = color(2);
                outputRgb(ii, jj, 3) = color(3);
            end
        end
    end 
    
end

