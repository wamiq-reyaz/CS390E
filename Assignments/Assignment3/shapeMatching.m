function [ rot, meanx, meany ] = shapeMatching( X, Y )
%SHAPEMATCHING Shape matching using SVD
%   ROT The calculated optimal rotation from Y to X
%   TRANSLATE The calculated optimal translation from Y to X

    [numx, dimx] = size(X);
    [numy, dimy] = size(Y);

    assert(dimx == dimy, 'The dimensionality of the pointclouds must be same');
    assert(numx > 0, 'X is empty');
    assert(numy > 0, 'Y is empty');

    % center both data matrices
    meanx = sum(X, 1) / numx;
    meany = sum(Y, 1) / numy;
    
    X = bsxfun(@minus, X, meanx);
    Y = bsxfun(@minus, Y, meany);
    
    % Find principal directions
    [~, ~, Vx] = svd(X);
    [~, ~, Vy] = svd(Y);

    % Calculate matrices
    rot = Vx * Vy';
    
    %% Tests
    
    % Ensure valid rotation matrix
    assert(det(rot) - 1.00 < 1e-3); 
    
    % Orthogonality
    orth_left = rot' * rot;
    diff = eye(dimx) - orth_left;
    assert(abs(det(diff)) < 1e-3);
    
    orth_right = rot * rot';
    diff = eye(dimx) - orth_right;
    assert(abs(det(diff)) < 1e-3);
end

