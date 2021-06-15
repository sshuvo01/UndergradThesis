function [ coords ] = getBaseCoords( bin, strWidth )
%strWidth = stroke width
    %figure(222), imshow(bin);
    
    CC = bwconncomp(bin, 4);
    %CC.PixelIdxList{1}

    %testBed = zeros(size(bin));
    [~, ccc] = size(CC.PixelIdxList);

    %minMaxPairs = makeCoordPair(-1, -1, -1, -1);
    coords = Coord(-1, -1);
    index = 1;


    for ii = 1:ccc
        [rows, cols] = ind2sub(size(bin), CC.PixelIdxList{ii}');
        [maxVal, maxInd] = max(rows);
        [minVal, minInd] = min(rows);

        minCoord = Coord(minVal, cols(minInd));
        maxCoord = Coord(maxVal, cols(maxInd));
        
        heightOfWR = maxCoord.x - minCoord.x + 2;
        
        if heightOfWR >= 1*strWidth
            %minMaxPairs(index) = CoordPair(minCoord, maxCoord);
            coords(index) = minCoord;
            index = index + 1;
        end %end of if
        
        %testBed(CC.PixelIdxList{ii}') = 1;
    end

    

end %end of function

