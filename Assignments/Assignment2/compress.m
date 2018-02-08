%% compress.m
%% Author: Wamiq Reyaz, VCC, KAUST

function [img, l2_diff] = compress(input, num_bases)
% This function partially reconstructs 2D image from its SVD USV' using
% just the first num_bases of the U matrix.
% Usage:
% >>>> [img, l2_diff] = compress(input, 4) 
% img is a representation of the image using only 4 basis vectors obtained 
% from the SVD, l2_diff is the l2_difference between the original and the
% reconstructed image.
    
    assert(nargin == 2, 'Requires two arguments');

    [row, col, chan] = size(input);
    
    % the image is not empty
    assert(row>0 && col>0, 'Input image cannot be empty');
    
    if(chan==3) % hopefully RGB
        input = rgb2gray(input);
    end
    
    input = im2double(input);
    [U, S, V] = svd(input);
    
    % create empty image the size of the input
    img = zeros(row ,col);
    % add outer products corresponding to the first num_bases columns
    for i = 1:num_bases
        img = img + U(:, i)*V(:, i)' * S(i,i);
    end
    
    l2_diff = norm(input - img, 2);
    
end
