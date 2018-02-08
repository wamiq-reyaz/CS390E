%% **********************************************************************
% Basic SVD Question
% You are computing the SVD of a random matrix A (assuming the matrix has
% full column rank). 
% What is a basis for the column space / range space of A?
% What is a basis for the Null space of A?
% What is a basis for the orthogonal complement of the null space of A?
% What is a basis for the orthogonal complement of the range space of A?
% Just assign matrices to the variables defined below. The basis vectors
% have to be in the columns of these matrices.

A = randn(4) ;

[U, S, V] = svd( A );

ColumnSpace = U; % U is an orthogonal matrix with m columns

NullSpace = zeros(4);

OrtNullSpace = V; % The orthogonal complement of the null space of A is the
                  % row space of A

OrtColumnSpace = zeros(4);

%% **********************************************************************
% Basic SVD Image Compression
% You are computing the SVD of a random matrix A (assuming the matrix has
% full column rank).
% Load an image
% Compute the truncated SVD for k = 1, 5, 10, 50, ... and observe how the
% image changes. Plot the results and pick some reasonable additional
% values for k.

% IO
demo_img = imread('face.jpg');
[row, col, chan] = size(demo_img);
demo_img_size = min(row, col); % The rest of the bases are zero vectors

num_reconstruction_bases_list = [1, 5 ,10, 50, 100, 200, 400, demo_img_size];

% Plotting
figure('Name', 'L2 loss v num_bases');
idx = 1;
for i=num_reconstruction_bases_list
    subplot(2,4,idx);
    [img, l2] = compress(demo_img, i);
    imshow(img); title(['bases ' num2str(i) ' L2 difference :' num2str(l2)]);
%     imwrite(img, ['demo/face' num2str(i) '_' num2str(l2, 1) '.png'])
    idx = idx + 1;
end

%% **********************************************************************
% Find an image that compresses really well using this technique. 
% Something with a lot of dependent rows/columns. Example: a checkerboard
% I have a 512*512 image completely represented with just 2 basis vectors
checker = imread('checker.png');
[img_checker, l2_checker] = compress(checker, 2);

% Find an image that does not compress well.
% Something that is full rank. Example: A random matrix
random = rand(512);
[img_noise, l2_noise] = compress(random, 2);


figure('Name', 'Comparison of reconstruction using 2 basis vectors');
% Original
subplot(2,2,1);
imshow(checker); title(['Original Checkerboard']);

subplot(2,2,2)
imshow(random); title(['Original random image']); 

% Reconstruction
subplot(2,2,3);
imshow(img_checker); title(['L2 difference = ' num2str(l2_checker)]);

subplot(2,2,4)
imshow(img_noise); title(['L2 difference = ' num2str(l2_noise)]);
% Please check what the image commands below do

% Img = imread(['face.jpg']);   Read an image into a row*column*channel
% array
% Img = rgb2gray( Img ); Average 3 RGB channels to get a greyscale image
% Img = im2double( Img ); range map from int(1-255) to double(0-1)
% figure('name','Original image'); imshow(Img); display image

%% **********************************************************************
% Eigenfaces
% 1 Load a database of faces
% 2 Convert the face database to a matrix so that each column of the matrix
% contains a face.
% 3 Compute a set of k basis vectors for the space of faces using SVD. These
% basis vectors can again be interpreted as face images.
% 4 Display the first 10 basis vectors as face images.
% 5 Project the given faces in the reduced basis and see how well a given
% image can be compressed / represented given only k basis vectors. This
% might be too much compute / analyze for a large number of faces. Just
% pick a few random faces and try to reconstruct them with k = 1, 3, 5, 10,
% 20, 50, ... basis vectors. What is a good number of k to get a reasonable
% trade off between compression and reconstruction quality
%
% matlab command: reshape, imagesc
% warning: pixel values can be float[0 - 1] or int[0 - 255]. Make sure
% there are no conversion issues.
% warning: basis vectors are not necessarily nice images by themselves. When
% displaying matrices / vectors as images something bad often happens. They
% can contain negative values. Maybe they can contain values that are too
% small. Maybe they can contain values that are too big. Look at different
% forms of range mapping and at different forms of image display

load('faces_76x55_grayscale.mat')
% figure('name','Face Image 17');
% Face17 = faces_gray{1};
% imshow( Face17 );

% How many images are there?
[NUM_IMAGES, ~] = size(faces_gray);

%How big is one image?
[ROW, COL] = size(faces_gray{1});
num_eig_faces = min(ROW*COL, NUM_IMAGES);

%Convert a face into a vector.

% v = reshape(faces_gray{1}, ... , ... );



% Do some great coding here.
img_database = zeros(ROW*COL, NUM_IMAGES);

% fill the database columns with flattened images
for i=1:NUM_IMAGES
    img_database(:, i) = reshape(faces_gray{i}, ROW*COL, 1);
end

% get the eigenfaces
bases = eigenfaces(img_database, num_eig_faces);

for i=1:10
    subplot(2,5,i);
    imagesc(reshape(bases(:, i), ROW, COL)); colormap(flipud(gray));
    axis off;
end

%% 
% Write out images for Face #17 reconstructed using a different number of
% basis functions. You can compare to my reference solution in the folder
% results.
face17 = im2double(faces_gray{17});

image_files_list = dir('Results');
[length, ~] = size(image_files_list); 
length = length - 2; % -2 for . ..
num_bases_list = zeros(length, 1);

for i=1:size(num_bases_list, 1) 
    offset = 2; % index begins from 3, because . .. are the first two elements
    name = image_files_list(i + offset).name;
    num = strsplit(name, '_'); num = num{2};
    num = strsplit(num, '.'); num = num{1};
    num_bases_list(i) = str2num(num);
end

 
figure;
idx = 1;
for i=num_bases_list(:)'
    subplot(2, 10, idx);
    reference = im2double(imread(['Results/Face17_' num2str(i) '.png']));
    img = reconstruct(face17, bases, i);
    imagesc(reference - img); colormap(flipud(gray)); axis off;
    l2_diff = norm(reference - img, 2);
    title(['L2 diff: ' num2str(l2_diff)]); 
    idx = idx + 1;
end
