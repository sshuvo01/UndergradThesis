classdef Coord
    properties
        x;
        y;
    end
    
    methods
        function obj = Coord(xx, yy)
            obj.x = int64(xx);
            obj.y = int64(yy);
        end
    end
    
end

