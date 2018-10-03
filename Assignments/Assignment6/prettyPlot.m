function [ handle ] = prettyPlot( F, x, y, z, c)
%PRETTYPLOT Plots pretty meshes
% PRETTTYPLOT(F, x, y, z, c) 
    if nargin == 5
        handle = trisurf(F, x, y, z, c);
    else
        handle = trisurf(F, x, y, z);
    end
    
%     set(handle, 'Visible', 'off');
    
    set(gcf,'Color',0.94*[1 1 1]);
    
    pink = [254 194 194]/255;
    bg_color = pink;

    axis equal;
    axis([-2     2      -2      2      -2 2]);
    axis vis3d;
    view([2, 2, 2])

    l = light('Position',[10 10 10],'Style','local');
    lighting gouraud;
%     shading interp;

    set(gcf,'Color',bg_color);
    axis off; 
end

