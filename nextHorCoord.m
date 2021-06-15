function [ outCoord ] = nextHorCoord(inCoord, dir )
    %1 = left to right
    %-1 = right to left
    global originalImg;
    global originalImgRow;
    global originalImgCol;
    
    startC = inCoord.y+dir;
    endC = originalImgCol;
    
    if dir == -1
        endC = 1;
    end % end of if
   
    outCoord = Coord(-1, -1);
    found = 0;
    foundCol = -1;
    
    for c = startC:dir:endC
        if originalImg(inCoord.x, c) == 0 %black
            outCoord = Coord(inCoord.x, c);
            found = 1;
            foundCol = c;
            break;
        end %end of if
    end %
  
    if found == 0
        return;
    end %end of if
    
    %found == 1 here
    height = 0;
     for c = startC:dir:foundCol
         height = maxBlackHeight(inCoord.x, c);
         if height == -1
             outCoord = Coord(-1, -1);
             return;
         end % end of for
     end %end of for
 
    
end

