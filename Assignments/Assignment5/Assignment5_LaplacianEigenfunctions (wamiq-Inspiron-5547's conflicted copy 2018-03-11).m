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


path = 'boundary.obj'; 
% path = '../data/mesh/teddy.obj'; 
[V, F] = read_obj(path);     
%%
trimesh(F, V(:, 1), V(:, 2), V(:, 3));
lighting gouraud
shading interp
axis off
%%
% Compute the cotan matrix and the area weight matrix from assignment 4
[areaMat, cotMat] = cotArea(F, V);

%%
L = cotMat;
% Compute the eigenfunctions of the Laplacian operator and write the first
% 100 basis functions to a file. (Similar to the images in the course notes
% or book). Please use a consistent color map for all the images and a
% consistent view point. This should be computed automatically. See the
% Eigenface example for how to write out a sequence of images that is
% numbered.

numBases = 5;
[bases, eigVal] = eigs(L, numBases, 'sm');
%%
BASE_DIR = './manifoldHarmonics/';
EXT = '.svg';
reverseStr = '';

for ii=1:numBases
    h = prettyPlot(F, V(:, 1), V(:, 2), V(:, 3), bases(:, ii));
    saveas(h, [BASE_DIR  num2str(ii) EXT]);
    set(h, 'Visible', 'off');
    
    msg = sprintf('saved %d\n', ii);
    fprintf([reverseStr msg]);
    reverseStr = repmat(sprintf('\b'), 1 ,length(msg));   
end

% ....

% Compress the mesh by using the Eigenfunctions to iteratively reconstruct
% the 3D surface. See Figure 4.3 in the geometry processing book. Write the
% results to images containing the rendered 3D models.

%%
% x = bases(:, 1)'*V(:, 1) * bases(:, 1);
% y = bases(: ,1)'*V(:, 2) * bases(:, 1);
% z = bases(:, 1)'*V(:, 3) * bases(:, 1);
% 
% trisurf(F, x, y, z);

% Use three different operators (low-pass, high-pass, enhancement) 
% in order to recreate the Fig. 4.4. from the book. You might want to look
% at the corresponding paper where the Figure comes from. Again, write out
% the three results to an image file.

% ....