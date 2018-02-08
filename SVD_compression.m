img = imread('noise.png');
% img = imresize(img, 1/8);
img = im2double(img);
[row, col, chan]  = size(img);

if(chan ==3)
    img = rgb2gray(img);
end


BASES = int32(min(col, row));
NUM_IMAGES = int32(8);
STEP_SIZE = int32(BASES / NUM_IMAGES);

[U, S, V] = svd(img);

partials = cell(1, NUM_IMAGES);

for i=1:100
    partials{i} = 0;
end

idx = 1;
for i=1:100
    sprintf('%d', i);
    for j = 1:i
        partials{idx} = partials{idx} + U(:, j)*V(:,j)'*S(j,j);
    end
    idx = idx +1;
end

%% ********************************************************************* %%
imshow(mat2gray(partials{10}))

%% ********************************************************************* %%
% Plotting

figure;
title(['Total number of bases ' num2str(col)]);
for i= 1:100
    subplot(10,10, double(i));
    imwrite(partials{i}, ['noise/noise' num2str(i) '.png']);
    imshow(partials{i});
    num_bases = i;
    l2_error = norm(partials{i} - img, 2);
    title(['Number of bases: ', num2str(num_bases)]);
    xlabel(['L2 difference: ', num2str(l2_error)]);
end
