function [ boundedImg ] = bBoxImg( lineImg )
    [nRow, nCol] = size(lineImg);

    upRow = 1;
    downRow = nRow;

    leftCol = 1;
    rightCol = nCol;

    %calculating upRow
    found = false;
    for ii = 1 : nRow
        if found == true
            break;
        end
        for jj = 1 : nCol
            if lineImg(ii, jj) == 0
                upRow = ii;
                found = true;
                break;
            end
        end %end of for
    end %end of for

    %calculating downRow
    found = false;
    for ii = nRow:-1:1
        if found == true
            break;
        end % end of if
        for jj = 1 : nCol
            if lineImg(ii, jj) == 0 % black pixel
                downRow = ii;
                found = true;
                break;
            end %end of if
        end %end of for
    end

    %calculating leftCol
    found = false;
    for ii = 1 : nCol
        if found == true
            break;
        end
        for jj = 1 : nRow
            if lineImg(jj, ii) == 0
                leftCol = ii;
                found = true;
                break;
            end 
        end %end of for
    end %end of for

    %calculating rightCol
    found = false;
    for ii = nCol:-1:1
        if found == true
            break;
        end
        for jj = 1:nRow
            if lineImg(jj, ii) == 0
                rightCol = ii;
                found = true;
                break;
            end 
        end %end of for
    end %end of for

    boundedImg = lineImg(upRow:downRow, leftCol:rightCol);

end

