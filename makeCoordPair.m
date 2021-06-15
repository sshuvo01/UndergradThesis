function [ cp ] = makeCoordPair( x1, y1, x2, y2 )
    cp = CoordPair(Coord(x1, y1), Coord(x2, y2));
end

