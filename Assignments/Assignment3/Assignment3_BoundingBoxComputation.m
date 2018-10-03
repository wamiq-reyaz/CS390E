% Implement a 3D bounding box computation.
% a first version for debugging purposes should use 2d points as input 
% (set the last coordinate to zero) and display the results in 2d.
% 
% the extended version should display the points in 2D and 3D 
% just take the vertices of the bunny
% create a random rotation matrix and rotate all vertices of the bunny
% before computing the bounding box. Make sure that the result is
% consistent

path = '../Data/mesh/teddy.obj'; 
% path = 'tet.obj';
[V, F] = read_obj(path);

% Load data from test file
% testData

%% Plot
RotX3 = @(theta) ([cos(theta) -sin(theta) 0 ; sin(theta) cos(theta) 0; 0 0 1]);
DATA =  (RotX3(rand())* V')' ;
DATA = V;
  
% DATA = (RotX3(rand())* DATA')' ;
[ ur, ll, pc, center] = BBox(DATA);

figure('name','bunny');
% trimesh(F, V(:, 1), V(:, 2), V(:, 3));
scatter3(DATA(:, 1), DATA(:, 2), DATA(:, 3))
plotBBox(ur, ll, pc, center);

%%
DATA2D = [DATA(:, 1), DATA(:, 2)];
[ ur, ll, pc, center] = BBox(DATA2D);

figure('name', 'bunny 2D')
scatter(DATA2D(:, 1), DATA2D(:, 2));
plotBBox( ur, ll, pc, center)
