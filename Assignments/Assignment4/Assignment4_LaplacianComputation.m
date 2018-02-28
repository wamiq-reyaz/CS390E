%% **********************************************************************
% Reading
% geometry processing book, chapter 3. (follows the lecture slides on
% geometry)

%% **********************************************************************
% Load a mesh
% Compute the Laplacian for each mesh vertex. The Laplacian is a vector in
% similar direction to the normal vector.
% Compute the Laplacian in the following steps.

% Load a mesh

path = '../data/mesh/teddy.obj'; 
[V, F] = read_obj(path);     
trimesh(F, V(:, 1), V(:, 2), V(:, 3));

load LaplacianTeddyAnna.mat

% Compute the uniform Laplacian with weights of 1 and minus vertex valence
% in a row.

[adjMat, degMat] = adjacencyDeg(F, size(V, 1));

D_unif = inv(degMat);
M_unif = adjMat - degMat;

error_unif_area = norm(D_unif - D_unif_Anna, 'fro')
error_unif_laplacian = norm(M_unif - M_unif_Anna, 'fro')

% Compute the laplacian of the coordinate function
L = D_unif * M_unif * V;

% Visualize the uniform Laplacian as a small vector attached to each vertex
hold on;
scale = 2;
quiver3(V(:, 1), V(:, 2), V(:, 3), -L(:, 1), -L(:, 2), -L(:, 3), scale);
quiver3(V(:, 1), V(:, 2), V(:, 3), L(:, 1), L(:, 2), L(:, 3));
legend('', 'out', 'in');
camva(180)
axis off;

% Compute the Laplacian using cotan weights
[areaMat, cotMat] = cotArea(F, V);
M_cot = 0;


% Compute the area weighting matrix using mixed weights

D_cot = 0;


% Check for errors with Anna's solution

% error1 = norm(D_cot - D_cot_Anna, 'fro')
% error2 = norm(M_cot - M_cot_Anna, 'fro')

% Visualize the cotan Laplacian as a small vector attached to each vertex

% Visualize the area weights as colors on the mesh vertices
