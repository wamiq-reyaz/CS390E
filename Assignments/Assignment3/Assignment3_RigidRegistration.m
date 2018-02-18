% Implement a 3d rigid registration algorithm
% - read in a point cloud
% - create a copy of the point cloud
% - randomly translate and rotate the point cloud copy
% - add Gaussian noise to the vertices of the point cloud copy
% - visualize the two point clouds before and after the registration
% - create a 2d (projected) visualization and a 3d visualization

% ----------------------------------------
% parameters

tmin = [-1 -1 -1];  % minimum translation offset
tmax = [1 1 1];     % maximum translation offset
angle_max = 30;     % maximum rotation angle

% ----------------------------------------
% setup random translation and rotation

translation = tmin + rand(1,3) .* ( tmax - tmin);

rotation = ones(3, 3); % replace this with something

% ----------------------------------------
% load mesh

path = '../Data/mesh/simple_bunny.obj'; 
[V1, F1] = read_obj(path);
figure('name','bunny');
trimesh(F1, V1(:,1), V1(:,2), V1(:, 3));
axis off;

hold on;
figure('name','2D projected bunny');
plot(V1(:, 1), V1(:, 2), '.');

% create copy 
evilBunny = V1;

