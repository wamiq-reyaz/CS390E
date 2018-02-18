function [  ] = plotBBox( ur, ll, pc, center )
%PLOTBBOX Plots an object oriented bounding box. Wrapper around 2d and 3d
%plotters
    [dim, ~] = size(center);
    
    if(dim == 2)
        plotBBox2(ur, ll, pc, center);
    elseif(dim == 3)
        plotBBox3(ur, ll, pc, center);
    end
end


