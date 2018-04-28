%% **********************************************************************
% Load a mesh

close all; clear all;

path = 'teddy.obj'; 
% path = '../data/mesh/teddy.obj'; 
[V, F] = read_obj(path);     
trimesh(F, V(:, 1), V(:, 2), V(:, 3));

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


% create a rendering of the teddy after one, two, and tree, subdivision
% steps

% start with a cube or similar "sphere-like" object and also create
% different renderings after one, two, and three subdivision steps