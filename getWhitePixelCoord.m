function [ coord ] = getWhitePixelCoord( coordPair )
    global originalImg;
    global originalImgRow;
    global originalImgCol;

    c1 = coordPair.coord1;
    c2 = coordPair.coord2;
    row = c1.x - 1;
    
    for col = c1.y: c2.y
        if originalImg(row, col) == 1
            coord = Coord(row, col);
            
            return;
        end
    end %end of for
    %disp('danger')
    coord = Coord(-1, -1);
end

