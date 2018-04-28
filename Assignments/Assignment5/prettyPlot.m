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
    axis([-70     70      -130      10      -55 55]);
    axis vis3d;
    view([0, -10, -80])

    l = light('Position',[0 -10 -80],'Style','local');
    lighting gouraud;
    shading interp;

    set(gcf,'Color',bg_color);
    axis off; 
end

