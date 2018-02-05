% @name: Wamiq Reyaz
% @original_author: Peter Wonka

%% **********************************************************************
% Reading
% General reading about linear algebra: 
% Read page 3 to page 22 of Matrix Methods in Data Mining and Pattern Recognition

%% **********************************************************************
% Reading
% Reading about matlab: 
% read the slides for the matlab course. Especially the MIT course for
% introduction to matlab.

%% **********************************************************************
% Review
% Review on demand. Read only if needed: 
% Fundamentals of Computer Graphics Chapter 6 Transformation Matrices (Shirley)


%% **********************************************************************
% Create a 4x4 random matrix. 
 A_rand = rand(4);

%% **********************************************************************
% copy the 4 column vectors of A into the vectors a1, a2, a3, a4
% using appropriate index commands

a1 = A_rand(:, 1);
a2 = A_rand(:, 2);
a3 = A_rand(:, 3);
a4 = A_rand(:, 4);

%% **********************************************************************
% copy the top left submatrix of A into the matrix B
%
[row, col] = size(A_rand);
B = zeros(row);

for i = 1:col
    B(i, 1:col-i+1) = A_rand(i, 1:col-i+1);
end


%% **********************************************************************
% add another random column to make it a 4 x 5 matrix C
%

C = [B, rand(row, 1)];

%% **********************************************************************
% reshape the matrix C into a column vector col
% see matlab reshape

column_vec = reshape(C, [], 1);

%% **********************************************************************
% Compute the determinant of a random 10 x 10 matrix

determinant = det(rand(10));

%% **********************************************************************
% Create a random 4x4 orthogonal matrix

Q = eye(4);

%% **********************************************************************
% Show that the matrix multiplication of two n x n matrices scales with n^3. Use tic and toc 

NUM_EXPTS = 1000;

times = zeros(1, NUM_EXPTS);
for i=1:NUM_EXPTS
    A = randn(i);
    B = randn(i);
    tic
    C = A * B;
    times(i) = toc;
end

fit_curve = fit([1:NUM_EXPTS]', times', 'poly3');
hold on;
plot(times)
plot(fit_curve)
legend('Raw time data', 'Fitted cubic')

%% **********************************************************************
% Load a set of points from the provided file: EaglePoints2D.mat

% Loading and saving a matrix from file example.
% save('saveA.mat','A');
% example = matfile('saveA.mat');
% B = example.A;

mat_file = '../Data/points2Dmat/EaglePoints2D.mat';
points2DFile = matfile(mat_file);

points = points2DFile.points;

figure;
ax1 = subplot(1, 2, 1);
plot( points(1, :)', points(2, :)');
title('Transposed')

ax2 = subplot(1,2,2);
plot(points(1, :), points(2, :));
title('Untransposed');
% check if it should be transposed or not

% Not particularly necessary

%% **********************************************************************
% Create basic random 2D and 3D matrices
%
% Create a random matrix for each of the following classes of matrices:
% rotation, shear, mirroring, scaling, anisotropic scaling
% for each matrix compute the inverse and the eigenvalues and eigenvectors
% the random algorithm should pick some representative matrices randomly.
% e.g. for 2D rotations it should pick a random angle alpha and rotate
% around that. For scaling you can assume reasonable minimum and maximum
% values. e.g. picking scaling values in the interval [0, 1] is not reasonable
% because it is not balanced / symmetric / representative
%

% Why? Shrinking is a valid scaling operation.

% -----------Rotations-----------%
RotX2 = @(theta) ([cos(theta) -sin(theta); sin(theta) cos(theta)]);
RotX3 = @(theta) ([cos(theta) -sin(theta) 0 ; sin(theta) cos(theta) 0; 0 0 1]);

Rot2D = RotX2(rand(1));
Rot2DInv = inv(Rot2D);
[U, D] = eig( Rot2D );


Rot3D = RotX3(rand(1));
Rot3DInv = inv(Rot3D);
[U, D] = eig(Rot3D);

% ----------Mirroring------------%
% TODO

% -----------Shear---------------%
% No coordinate shears itself. Mask that out.
randShear2D = @() (rand(2)*2 .* [0 1; 1 0] + eye(2));
randShear3D = @() (rand(3)*5 .* [0 1 1; 1 0 1; 1 1 0] + eye(3));

Shear2D = randShear2D();
invShear2d = inv(Shear2D);
Shear3D = randShear3D();
invShear3D = inv(Shear3D);

% -----------Mirror--------------%
Mirror2D = eye(2);
invMirror2D = inv(Mirror2D);
Mirror3D = eye(3);
invMirror3D = inv(Mirror3D);

% -------Isotropic Scaling-------%
randScaling2D = @() (eye(2) * rand_1_5());
randScaling3D = @() (eye(3) * rand_1_5());

Scaling2D = randScaling2D();
invScaling2D = inv(Scaling2D);
Scaling3D = randScaling3D();
invScaling3D = inv(Scaling3D);

% ------Anisotropic Scaling----%
AScaling2D = randAScaling2D();
invASclaling2D = inv(AScaling2D);
AScaling3D = randAScaling3D();
invASclaling3D = inv(AScaling3D);

%% **********************************************************************
% Compute the determinants of the random 2D and 3D rotation matrices and
% the 2D and 3D mirror matrices. What can you observe about the
% determinants?

% Answer: The determinant is 1 for rotation matrices and -1 for mirror matrices.

%% **********************************************************************
%Create a degenerate version of each of these matrices
% so that they cannot be inverted. If a matrix can always 
% be inverted, do not generate a matrix for this class
% create the degenerate matrices with as few 0s as possible!!
% otherwise its too easy

% Rotation matrices cannot be made degenerate. Neither can be mirror or shearing matrices.
% Scaling on the other hand, is fair game.

Scaling2D = randScaling2D();
Scaling2D(1,1) = 0;  %set the x scale to 0
det(Scaling2D);

AScaling3D = randScaling3D();
AScaling3D(1,1) = 0;
det(AScaling3D);

%% **********************************************************************
% Create a simple 2D "Mesh viewer" in matlab
% The mesh viewer should be able to draw a set of points connected by a line
% For each of the matrices below, draw the mesh in original position and
% then transformed by a random matrix. Open one figure per transformation
% and name the figure according to the transformation: you can load
% EaglePoints2D or BunnyPoints2D for 2D meshes.
%
% 2D rotation, shear, mirroring, scaling, anisotropic scaling
% matlab commands: figure, plot

meshViewer2D = @(mesh) (plot(mesh(1, :), mesh(2, :))) ;

figure;
title('A mosaic of distorted eagles');
subplot(3,2,1)
meshViewer2D(points);
title('Original image');

subplot(3,2,2)
meshViewer2D(RotX2(pi/4) * points);
title('Rotated Image(pi/4)');

subplot(3,2,3)
meshViewer2D(randScaling2D() * points);
title('Scaled Image'); % You can't really see it here, but look at the axis

subplot(3,2,4)
meshViewer2D(randAScaling2D() * points);
title('Anisotropically scaled image'); % Again MATLAB messes it up

subplot(3,2,5)
meshViewer2D(randShear2D() * points);
title('Sheared image');


%% **********************************************************************
% Create other matrices
%
% Create a random matrix for each of the following classes of matrices:
% 4D matrices using homogenous coordinates:
% rotation, shear, mirroring, scaling, anisotropic scaling
% projection matrix using 4D homogenous coordinates
% 4x4 symmetric matrix
% 4x4 permutation matrix
% stochastic transition matrix (rows sum to 1)
% Laplacian Matrix (you can skip this one if its too difficult)
% 4x4 (upper) triangular matrix
% 4x4 diagonal matrix
% magic matrix
% Householder matrix (what is it?)
% for each matrix compute the inverse and the eigenvalues and eigenvectors
%

% -------Rotation-----------%
% x is the angle
RotX4 = @(x) ([cos(x) -sin(x) 0 0; sin(x) cos(x) 0 0; 0 0 1 0; 0 0 0 1]);

Rot4D = RotX4(rand(1));

% --------Shear-------------%
randShear4D = @() [randShear3D(), [0 0 0]'; [0 0 0 1]];
Shear4D = randShear4D();

% --------Reflection---------%
% The householder is also a reflection matrix
Reflection4D = randHouseholder4D();
det(Reflection4D);

% --------Scaling-----------%
randScaling4D = @() (eye(4) * rand_1_5());
Scaling4D = randScaling4D();

% --Anisotropic Scaling----%
AScaling4D = randAScaling4D();

% ---Projection Matrix-----%
% TODO
% Idea 1: We can generate random lr, fn, tb. But what about div by zero.
% There are 3 dangerous pairs. The probability that any one of them is
% equal is ____.


% ---Symmetric Matrix------%
% B'B is always symmetric
B = rand(4);
Symmetric4D = B' * B;

% -----Permutation Matrix--%
% we will generate random indices and swap the rows of the identity matrix 
% to generate the permutation matrix

Perm4D = eye(4);
idx = randperm(4);
Perm4D = Perm4D(idx, :);

% ---Transition Matrix-----%
Transition4D = eye(4);
for i=1:4
    Transition4D(i, :) = markovRow(4);
end

sum(Transition4D, 2);

% ----Laplacian Matrix-----%
% TODO

% --Upper triangular Matrix--%
UpperTri4D = rand(4);
UpperTri4D = triu(UpperTri4D);

% ----Diagonal Matrix------%
Diag4D = diag(rand(1,4));

% -----Magic Matrix--------%
Magic4D = magic(4);

% ----Housholder Matrix----%
Householder4D = randHouseholder4D();
det(Householder4D);
[U, D] = eig(Householder4D);

%% **********************************************************************
%% Try the built in point cloud tool
% try to rotate and zoom

path = '../Data/pointcloud/bunny.ply';
pcloud = pcread(path);
data = pcloud.Location;
pcshow(data); 
axis off;

%% **********************************************************************
% Create a simple time dependent 3D point animation in the viewer above in matlab
% that changes the camera to rotate the bunny
% matlab commands: axis off, camorbit, drawnow
%

% pcshow(data);
% This does not look nice, inverted on the side.
% Rotation matrix 90 clockwise about x
R = [1 0 0; 0 0 1; 0 -1 0];
rotated_data = data * R;
pcshow(rotated_data)

axis off;

for i = 1:720
    camorbit(0.5,0, 'camera');
    drawnow;
end

%% **********************************************************************
% Create a time dependent 3D point animation in the viewer above in matlab
% The mesh viewer should be able to draw a set of points
% take a random transformation, best probably a rotation matrix with a
% small angle. Then incrementally rotate the point cloud for a set number
% of iterations. The rotation should take about 10 seconds or so. It's
% important to note that you can change the data in the view after setting
% it up.
%
% matlab commands: drawnow

pcshow(rotated_data);
axis off;

for i = 1:30
    rotated_data = rotated_data * RotX3(0.05*i);
    pcshow(rotated_data);
    axis off;
    drawnow;
end


%% **********************************************************************
% Try to look into loading and visualizing 3D meshes. You can take whatever
% code you want for mesh visualization, but not for the data structures or
% algorithms. This is a simple way to get started. The viewer is not great.
% You can either try to find something better, or improve the viewer with
% the built in commands.

path = '../data/mesh/simple_bunny.obj';
[V, F] = read_obj(path);     
hold on;
trimesh(F, V(:, 1), V(:, 2), V(:, 3));

%% **********************************************************************
% Transform the object using some 3D matrices
% rotation matrix, symmetric matrix, singular matrix
% display the bunny before and after the transformation in the same figure.

hold on;
trimesh(F, V(:, 1), V(:, 2), V(:, 3));
axis off;

V_transformed = V * RotX3(pi);
trimesh(F, V_transformed(:,1), V_transformed(:, 2), V_transformed(:, 3));


