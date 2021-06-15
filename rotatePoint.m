function [ rotpoint ] = rotatePoint( point, theta )
    
    %thete degree counterclockwise
    %point, row vector
    R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
    % Rotate your point(s)
    point = point'; 
    rotpoint = R*point;
end

