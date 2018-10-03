%% **********************************************************************
% Load a mesh

close all; clear all;

path = 'cube.obj'; 
% path = 'teddy.obj'; 
[V, F] = read_obj(path);     
% compute loop subdivision
% do this in a separate file as a function


% Hint:
% create a matrix of edge-vertices of the new triangulation.
% 
% * edgeVertices(x,y,1): index of the new vertice between (x,y)
% * edgeVertices(x,y,2): index of the first opposite vertex between (x,y)
% * edgeVertices(x,y,3): index of the second opposite vertex between (x,y)
%
%  0riginal vertices: va, vb, vc, vd.
%  New vertices: vp, vq, vr.
%
%      vb                   vb             
%     / \                  /  \ 
%    /   \                vp--vq
%   /     \              / \  / \
% va ----- vc   ->     va-- vr --vc 
%   \     /              \      /
%    \   /                \    /
%     \ /                  \  /
%      vd                   vd     

% Hint: each edge will be called for splitting twice. Each time you can
% insert a different opposite vertex into the edgeVertices data structure
% Q: What about boundaries?

% create a rendering of the teddy after one, two, and tree, subdivision
% steps

% start with a cube or similar "sphere-like" object and also create
% different renderings after one, two, and three subdivision steps
trisurf(F, V(:, 1), V(:, 2), V(:, 3), 'FaceColor', 'interp');

lV = V; lF = F;
for ii= 1:1
    [lF, lV] = loopSub(lF, lV);
    figure(); axis equal;
    trimesh(lF, lV(:, 1), lV(:, 2), lV(:, 3));
end


PATH = ['~/Desktop/' path];
fid = fopen(PATH, 'w');
fprintf(fid, 'v %f %f %f\n', lV');
fprintf(fid, 'f %d %d %d\n', lF');
fclose(fid);

