function [width] = strokeWidth( img )
    [imgR, imgC] = size(img);
    
    curPixel = 1;
    prevPixel = 1;
    found = 0; % not found a black line
    count = 0;
    z = zeros(max(imgR, imgC));
    lengthCount = z(1, :);
    
    %horizontal scan
    for r = 1:imgR
        count = 0;
        found = 0;
        prevPixel = 1; %assume that it is initially white
        for c = 1:imgC
           curPixel = img(r, c);
           
           if prevPixel == 1 %prevPixel is white
               if curPixel == 0 && found == 0
                   found = 1; % found a line
               end % 
               
               
           else %prevPixel is black
               if curPixel == 1 && found == 1
                   found = 0; %end of line
                   lengthCount(count) = lengthCount(count) + 1;
                   count = 0;
              
                   
               end 
               
           end % end of if
           if found == 1
               count = count +1;
           end
           prevPixel = curPixel;
        
        end %end of for
    end %end of for
   %vertical scan
    for c = 1:imgC
        count = 0;
        found = 0;
        prevPixel = 1; %assume that it is initially white
        for r = 1:imgR
           curPixel = img(r, c);
           
           if prevPixel == 1 %prevPixel is white
               if curPixel == 0 && found == 0
                   found = 1; % found a line
               end % 
               
               
           else %prevPixel is black
               if curPixel == 1 && found == 1
                   found = 0; %end of line
                   lengthCount(count) = lengthCount(count) + 1;
                   count = 0;
              
                   
               end 
               
           end % end of if
           if found == 1
               count = count +1;
           end
           prevPixel = curPixel;
        
        end %end of for
    end %end of for
    
    
    [maxVal, maxInd] = max(lengthCount);
    
    width = maxInd;
    
end % end of function

