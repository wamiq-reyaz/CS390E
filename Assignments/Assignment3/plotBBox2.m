function [  ] = plotBBox2( ur, ll, pc, center )
%PLOTBBOX2 
    % Find all four corners for plottting rectangle
    xDiff = ur(1) - ll(1);
    yDiff = ur(2) - ll(2);
    
    lr = ll + [xDiff; 0];
    ul = ll + [0; yDiff];
    
    % Inverse rotation 
    vertices = [ur, ll, lr, ul];
    vertices
    vertices = pc' * vertices;
    
    % Inverse Translation
    for ii=1:4
        vertices(:, ii) = vertices(:, ii) + center;
    end
    
    plotRectangle(vertices);
end

