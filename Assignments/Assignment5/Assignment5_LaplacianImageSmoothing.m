%% **********************************************************************
% Reading
% geometry processing book, section 4.2

%% **********************************************************************
% Load an image

Img = im2double(imread('Nice.jpg'));
% imshow(Img);

a = del2(Img(:, :, 1));
figure()
imshow(a*100)
% Compute the Laplacian matrix for the image. Use boundary conditions where
% you copy the first / last rows / columns. Basically, you assume that the
% value of a pixel outside the boundary is the same as the closest pixel
% inside the boundary.

% Limg = ...;

% Do some analysis. Call Eigenvalue / Eigenvector decomposition. 
% Check that the matrix is symmetric.
% Yes? No? Is the matrix singular?
% Write out the first 50 Eigenvectors as images to files. Use appropriate
% color / range mapping.

EigenVecs = 42; % replace with Eigenvector matrix
EigenVals = 42; % replace with Eigenvalue matrix

IsMatrixSingular = 42; % replace with true or false
IsMatrixSymmetric = 42; % replace with true or false

% Compute iterative smoothing with different time steps. Try to determine a
% time step that is too large, a time step that is too small, and a time
% step that is best / recommended in your point of view. Is there a time
% step that can lead to the program to crash / produce infinite values in
% the image?

tSlow = 42; % replace with your values
tFast = 42;
tBest = 42;

% Choose the best time step and write images from the first 50 smoothing
% iterations out to png files.

% look up some related matlab functions. They might not be
% directly usable for computing the matrix L, but they are
% useful for computing the result L*I;
% circshift, filter2, del2, padarray

