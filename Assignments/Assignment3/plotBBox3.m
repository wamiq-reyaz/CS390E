function [  ] = plotBBox3( urf, llb, pc, center )
%PLOTBBOX3
    % I will be lazy and use six calls to plotRectangle
    % Find all 8 corners for plottting cube
    xDiff = urf(1) - llb(1);
    yDiff = urf(2) - llb(2);
    zDiff = urf(3) - llb(3);
    
    llf = llb + [0; 0; zDiff];
    ulb = llb + [0; yDiff; 0];
    lrb = llb + [xDiff; 0; 0];
    
    ulf = urf - [xDiff; 0; 0];
    lrf = urf - [0; yDiff; 0];
    urb = urf - [0; 0; zDiff];
    
    % Inverse rotation
    % back faces first, front faces later
    vertices = [urb, llb, lrb, ulb, urf, llf, lrf, ulf];
    vertices = pc * vertices;
    
    % Inverse Translation
    for ii=1:8
        vertices(:, ii) = vertices(:, ii) + center;
    end
    
    vertices([2, 8])
    
    % inelegant
    plotRectangle(vertices(:, 1:4));
    plotRectangle(vertices(:, 5:8));
    
    side1 = [vertices(:, 1), vertices(:, 7), vertices(:, 3), vertices(:, 5)];
    side2 = [vertices(:, 4), vertices(:, 6), vertices(:, 2), vertices(:, 8)];
    plotRectangle(side1);
    plotRectangle(side2);
    
%     top = [vertices(:, 5), vertices(:, 6), vertices(:, 7), vertices(:, 8)];
%     bottom = [vertices(:, 1), vertices(:, 2), vertices(:, 3), vertices(:, 4)];
%     plotRectangle(top);
%     plotRectangle(bottom);

end

