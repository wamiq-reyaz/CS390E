%% reconstruct.m
%% Author: Wamiq Reyaz, VCC, KAUST

function [img] = reconstruct(image, eigfaces, num_bases)
% RECONSTRUCT returns an image reconstructed using only num_bases basis
% vectors of eigfaces.
% Image is an image matrix. The basis for the image must be in the columns
% of eigfaces. 

    assert(nargin == 3, 'Requires three arguments');
    
    [row, col, chan] = size(image);
    assert(row > 0 && col > 0, 'Input image cannot be empty');
    
    if(chan == 3)
        image = rgb2gray(image);
    end
    
    img = zeros(size(image));
    
    % should probably call reshape only once at the end
    image = reshape(image, row*col, 1);
    for i=1:num_bases
        contrib_i = ((eigfaces(:, i)' * image) * eigfaces(:, i));
        img = img + reshape(contrib_i, row, col);
    end
    
end