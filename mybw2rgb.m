function [ rgb ] = mybw2rgb( bw )
    [bwRow, bwCol] = size(bw);
    rgb = zeros(bwRow, bwCol, 3);
    
    for r = 1:bwRow
        for c = 1:bwCol
            if bw(r, c) == 1
                rgb(r, c, :) = 255;
            end
        end % end of for
    end %end of for
    
end

