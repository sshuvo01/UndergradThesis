function [ baseCoords2 ] = GetBaseCoordsFromImg(  )
        %uses originalImg
        global originalImg;
        global originalImgRow;
        global originalImgCol;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        blankCol = 1;
        prevHeight = 0;
        curHeight = 0;

        wrCoordPairs = makeCoordPair(-1, -1, -1, -1); %first one is invalid
        index = int64(2);

        curCol = 1;
        
        while curCol <= originalImgCol
            h = maxBlackHeight(originalImgRow, curCol);
           % disp(curCol);
            if h == -1% no black pixels
                curCol = curCol + 1;
                continue;
            end % end of if

            nextCoord = nextHorCoord(Coord(h, curCol), 1); %1 = left to right, -1 = right to left

            if nextCoord.x ~= -1 && nextCoord.y ~= -1 && nextCoord.y ~= curCol + 1
                wrCoordPairs(index) = CoordPair(Coord(h, curCol), nextCoord);
                index = index + 1;
                %curCol = nextCoord.y;
                curCol = curCol + 1;
            else
                curCol = curCol + 1;
            end %end of if
        end %end of while
        %right to left scanning
        curCol = originalImgCol;

        while curCol >= 1
            h = maxBlackHeight(originalImgRow, curCol);
           % disp(curCol);
            if h == -1% no black pixels
                curCol = curCol - 1;
                continue;
            end % end of if

            nextCoord = nextHorCoord(Coord(h, curCol), -1); %1 = left to right, -1 = right to left

            if nextCoord.x ~= -1 && nextCoord.y ~= -1 && nextCoord.y ~= curCol - 1
                wrCoordPairs(index) = CoordPair(nextCoord, Coord(h, curCol));
                index = index + 1;
                %curCol = nextCoord.y;
                curCol = curCol - 1;
            else
                curCol = curCol - 1;
            end %end of if
        end %end of for
        %%
        [~, nCol] = size(wrCoordPairs);
%         disp('nCol');
%         disp(nCol);
%         temp = originalImg;
%         for i = 2:nCol
%             c1 = wrCoordPairs(i).coord1;
%             c2 = wrCoordPairs(i).coord2;
%             temp(c1.x, c1.y:c2.y) = 0;
%         end
        %figure, imtool(temp);
        originalImgGray = uint8(255 * originalImg);
        
        for i = 2:nCol
            temp = originalImg;
            c1 = wrCoordPairs(i).coord1;
            c2 = wrCoordPairs(i).coord2;
            temp(c1.x, c1.y:c2.y) = 0; %make it black
            label = bwlabel(temp, 4);          %label connected components
            whitePixelCoord = getWhitePixelCoord(wrCoordPairs(i));  
            if whitePixelCoord.x == -1 && whitePixelCoord.y == -1
                continue;
            end %end of if
            labelVal = label(whitePixelCoord.x, whitePixelCoord.y);
            if labelVal == temp(1, 1)
                continue;
            end %end of if
            originalImgGray(label == labelVal) = 128;
            
        end % end of for
        %figure (2), imtool(originalImgGray);
        %figure(420), imshow(originalImgGray);
        %%
        waters = zeros(size(originalImg));
        waters(originalImgGray == 128) = 1;
        waters = logical(waters);

        sw = strokeWidth( originalImg );
        baseCoords2 = getBaseCoords(waters, sw); %sw = stroke width
        imtool(originalImgGray);
end %end of function

