%% **********************************************************************
% Load a mesh

clc
close all; clear all;

path = 'head.obj'; 
[V, F] = read_obj(path);     
trimesh(F, V(:, 1), V(:, 2), V(:, 3));

% compute the boundary constraint vectors. We need constraints for u and v,
% so the constraints should be stored in a matrix with two column vectors.

Constraints2D = 42;

% Compute a Laplacian matrix with uniform weigthts

Luniform = 42;

% Compute a Laplacian matrix with cotan weights

Lcotan = 42;

% Compute a Laplacian matrix with mean value weights

Lmeanvalue = 42;

% Solve the three different systems and draw the results

% Save out the results as png files
