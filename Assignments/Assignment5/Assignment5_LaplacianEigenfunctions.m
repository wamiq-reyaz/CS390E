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


path = 'gargoyle85k.obj'; 
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
L = cotMat; % we use the symmetric form of the matrix
% Compute the eigenfunctions of the Laplacian operator and write the first
% 100 basis functions to a file. (Similar to the images in the course notes
% or book). Please use a consistent color map for all the images and a
% consistent view point. This should be computed automatically. See the
% Eigenface example for how to write out a sequence of images that is
% numbered.

numBases = 10000;
[bases, eigVal] = eigs(L, numBases, 'sm');
%%
% BASE_DIR = './manifoldHarmonics/';
% EXT = '.png';
% 
% for ii=1:numBases
%     h = prettyPlot(F, V(:, 1), V(:, 2), V(:, 3), bases(:, ii));
%     saveas(h, [BASE_DIR  num2str(ii) EXT]);
%     set(h, 'Visible', 'off');
% end

% Compress the mesh by using the Eigenfunctions to iteratively reconstruct
% the 3D surface. See Figure 4.3 in the geometry processing book. Write the
% results to images containing the rendered 3D models.

%%

BASE_DIR = './fullReconstruction/';
EXT = '.png';

numVerts = length(V);
x = zeros(numVerts, 1);
y = zeros(numVerts, 1);
z = zeros(numVerts, 1);
for ii=1:1000
    x = x + bases(:, ii)'*V(:, 1) * bases(:, ii);
    y = y + bases(:, ii)'*V(:, 2) * bases(:, ii);
    z = z + bases(:, ii)'*V(:, 3) * bases(:, ii);
    
    h = prettyPlot(F, x, y, z); colormap gray;
    saveas(h, [BASE_DIR  num2str(ii) EXT]);
    set(h, 'Visible', 'off');
    
end

%%
% Use three different operators (low-pass, high-pass, enhancement) 
% in order to recreate the Fig. 4.4. from the book. You might want to look
% at the corresponding paper where the Figure comes from. Again, write out
% the three results to an image file.
