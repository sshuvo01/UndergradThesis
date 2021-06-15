function [ height ] = maxBlackHeight( row, col )
    %
    % height = -1 if no black pixel in the column col
    % 
    global originalImg;
    global originalImgRow;
    global originalImgCol;
    
    for r = row:-1:1
        if originalImg(r, col) == 0
            %disp('col');
            %disp(col);
            %disp('r');
            %disp(r);
            
            height = r;
            return;
        end%end of if
    end %end of for
    
    height = -1;
end



