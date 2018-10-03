%% **********************************************************************
% Load a mesh
 
clc
close all; clear all;
path = 'cubeb.obj'; 
[V, F] = read_obj(path);   
trisurf(F, V(:, 1), V(:, 2), V(:, 3));
 
nVert = size(V, 1);
nFace = size(F, 1);
 
%% compute the boundary constraint vectors. We need constraints for u and v,
% so the constraints should be stored in a matrix with two column vectors.
[arMat, cotMat] = cotArea(F, V);
cotMat = arMat * cotMat;
[adj, deg] = adjacencyDeg(F);
 
% adj returns 0.5 for boundary edges
bound = adj == 0.5;
adj(bound) = 1;

%% Show boundary vertices
[u, v ,~] = find(bound);
 
colr = zeros(size(V, 1), 1);
colr(u) = 1;
colr(v) = 1;
 
trisurf(F, V(:, 1), V(:, 2), V(:, 3), colr, 'FaceColor', 'interp'); hold on;
scatter3(V(:, 1), V(:, 2), V(:, 3), 12 + colr*32,  1-colr, 'filled'); hold off;

%% Order boundary vertices
[order, dist] = adj2bound(bound, V);

theta = 2*pi;
cons = [zeros(nVert, 1), zeros(nVert, 1)];
cons(order, :) = [cos(theta*dist), sin(theta*dist)];
 
% Compute a Laplacian matrix with uniform weigthts
deg = -deg;
normalUni = (adj + deg) ./ diag(deg);
 
% Compute a Laplacian matrix with cotan weights
normalCot = cotMat ./ diag(cotMat);

% Compute a Laplacian matrix with mean value weights
[arMat, meanMat] = meanArea(F, V);
normalMean = meanMat ./ diag(meanMat);

 
%%
% Solve the three different systems and draw the results
normalCot(order, :) = zeros(length(order), nVert);
normalCot(sub2ind(size(normalCot), order, order)) = 1;
% M(order, :) = cons(order, :);

cotU = normalCot \ cons(:, 1);
cotW = normalCot \ cons(:, 2);

%
normalUni(order, :) = zeros(length(order), nVert);
normalUni(sub2ind(size(normalUni), order, order)) = 1;
% M(order, :) = cons(order, :);

uniU = normalUni \ cons(:, 1);
uniW = normalUni \ cons(:, 2);

%
normalMean(order, :) = zeros(length(order), nVert);
normalMean(sub2ind(size(normalMean), order, order)) = 1;
% M(order, :) = cons(order, :);

meanU = normalMean \ cons(:, 1);
meanW = normalMean \ cons(:, 2);
 
%%
% Save out the results as png files
figure(); title('Cotangent Weights');
viscircles([0, 0], 1); 
trimesh(F, cotU, cotW); 

figure(); title('Uniform Weights');
viscircles([0, 0], 1); 
trimesh(F, uniU, uniW); 

figure(); title('Mean Value Weights');
viscircles([0, 0], 1); 
trimesh(F, meanU, meanW); 