 %% **********************************************************************
% Reading
% geometry processing book, chapter 3. (follows the lecture slides on
% geometry)

%% **********************************************************************
% Load a mesh
% Compute the Laplacian for each mesh vertex. The Laplacian is a vector in
% similar direction to the normal vector.
% Compute the Laplacian in the following steps.

DEBUG = false;

% Load a mesh
path = '../data/mesh/teddy.obj'; 
[V, F] = read_obj(path);     

load LaplacianTeddyAnna.mat

% Compute the uniform Laplacian with weights of 1 and minus vertex valence
% in a row.

[adjMat, degMat] = adjacencyDeg(F);

D_unif = inv(degMat);
areaVec = full(sum(D_unif, 2));
M_unif = adjMat - degMat;

% % compute deviation from reference solution
% error_unif_area = norm(D_unif - D_unif_Anna, 'fro');
% error_unif_laplacian = norm(M_unif - M_unif_Anna, 'fro');

% Compute the laplacian of the coordinate function
L = D_unif * M_unif * V;

% Visualize the uniform Laplacian as a small vector attached to each vertex
trimesh(F, V(:, 1), V(:, 2), V(:, 3), areaVec);colorbar;
hold on;
vizLaplacian(V, L, 2);


% Compute the Laplacian using cotan weights
% Compute the area weighting matrix using mixed weights

if DEBUG
    V = [0 0 0; 1 0 0;  1 1 0; 0 1 0];
    F = [1 2 3; 1 3 4];
end

[areaMat, cotMat] = cotArea(F, V);
D = 0.5 * inv(areaMat);
areaVec = full(sum(areaMat, 2)); % used as color for vertices

L_cot = D*cotMat*V;

% compute deviation with Anna's solution
error1 = norm(cotMat - M_cot_Anna, 'fro')
error2 = norm(D - D_cot_Anna, 'fro')

csvwrite('annaArea.csv', full(D_cot_Anna));
csvwrite('wamArea.csv', full(D));

% Visualize the cotan Laplacian as a small vector attached to each vertex
figure();
trisurf(F, V(:, 1), V(:, 2), V(:, 3), areaVec, 'FaceColor', 'interp'); colorbar;
hold on;
vizLaplacian(V, L_cot,20);


