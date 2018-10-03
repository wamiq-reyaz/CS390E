% Implement a 3d rigid registration algorithm
% - read in a point cloud
% - create a copy of the point cloud
% - randomly translate and rotate the point cloud copy
% - add Gaussian noise to the vertices of the point cloud copy
% - visualize the two point clouds before and after the registration
% - create a 2d (projected) visualization and a 3d visualization

% ----------------------------------------
% parametersrgfdg

tmin = [-1 -1 -1];  % minimum translation offset
tmax = [1 1 1];     % maximum translation offset
angle_max = 30;     % maximum rotation angle

% ----------------------------------------
% setup random translation and rotation

translation = tmin + rand(1,3) .* ( tmax - tmin);

RotX3 = @(theta) ([cos(theta) -sin(theta) 0 ;
                   sin(theta) cos(theta) 0; 
                   0 0 1]);
               
rotation = RotX3(rand(1)/2); % This is half a radian limit. Almost 30 deg

% ----------------------------------------
% load mesh

path = '../Data/mesh/simple_bunny.obj'; 
[V1, F1] = read_obj(path);

% create copy 
V2 = V1;

% Random translation
V2 = bsxfun(@plus, V2, translation);

% Random rotation
V2 = V2 * rotation';

% Perturbation
NOISE = 1e-2;
V2 = V2 + NOISE * randn(size(V2));


% Prediction
[predRot, mean1, mean2] = shapeMatching(V1, V2);

% Apply transformations. 
V2_r = bsxfun(@minus, V2, mean2);
V2_r = V2_r * predRot';
V2_r = bsxfun(@plus, V2_r, mean1);

% Plotting
figure('name', '');
subplot(221)
hold on;
trimesh(F1, V1(:,1), V1(:,2), V1(:, 3));
trimesh(F1, V2(:,1), V2(:,2), V2(:, 3));
legend('Original', 'Perturbed');
view(3)

subplot(222)
hold on;
plot(V1(:, 1), V1(:, 2), '.');
plot(V2(:, 1), V2(:, 2), '.');
legend('Original', 'Perturbed');

subplot(223)
hold on;
scatter3(V1(:,1), V1(:,2), V1(:, 3), 'x');
scatter3(V2_r(:,1), V2_r(:,2), V2_r(:, 3), '.');
legend('Original', 'Perturbed');
view(3)

subplot(224)
hold on;
plot(V1(:, 1), V1(:, 2), 'x'); alpha 0.5;
plot(V2_r(:, 1), V2_r(:, 2), '.'); alpha 0.5;
legend('Original', 'Perturbed');




