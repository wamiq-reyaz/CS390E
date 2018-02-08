%% eigenfaces.m
%% Author:  Wamiq Reyaz, VCC, KAUST

function [bases] = eigenfaces(database, num_bases)
% EIGENFACE Returns a set of basis for the given database of images
% bases = EIGENFACE(database, 3) returns 3 bases for the images in the
% database
% Note that the images must be in the columns of database
    assert(nargin == 2, 'Requires two arguments')
    assert(num_bases > 0, 'The number of bases must be between 0 and the size of the database')

    [row, col] = size(database);
    assert(row>0 && col>0, 'The database cannot be empty')
    
    [U, ~, ~] = svd(database);
    bases = U(:, 1:num_bases);
end