% Implement a 3D bounding box computation.
% a first version for debugging purposes should use 2d points as input 
% (set the last coordinate to zero) and display the results in 2d.
% 
% the extended version should display the points in 2D and 3D 
% just take the vertices of the bunny
% create a random rotation matrix and rotate all vertices of the bunny
% before computing the bounding box. Make sure that the result is
% consistent

path = '../Data/mesh/simple_bunny.obj'; 
[V, F] = read_obj(path);

% Load data from test file
testData

DATA = toy;
[ ur, ll, pc, eigen, center] = BBox(DATA);

figure('name','bunny');
hold on;

scatter(DATA(:, 1), DATA(:, 2));
% trimesh(F, V(:, 1), V(:, 2), V(:, 3));
plotBBox(ur, ll, pc, center);