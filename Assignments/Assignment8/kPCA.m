function [ basis ] = kPCA( mat, nBasis )
%KPCA returns a matrix 'basis' whose 'nDim' columns contain the orthonormal basis
%for the distance matrix given by 'mat'.

    [hh, ww] = size(mat);
    
    assert(hh == ww, 'Need a square matrix');
    assert(issymmetric(mat), 'Distances are symmetric');
    
    % center matrix
    avgMat = ones(hh) / hh;
    centerMat = mat - mat*avgMat - avgMat*mat + avgMat*mat*avgMat;
    
    % take nBasis eigenvalues
    [V, S, ~] = svd(centerMat);
    
    % Truncate 
    V = V(:, 1:nBasis);
    S = sum(S, 1); % get an array of eigenvalues
    S = S(1:nBasis);
    
    % Normalize
    V = V ./ sqrt(S);

    basis = V;
end

