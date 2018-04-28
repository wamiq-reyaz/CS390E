function [ basis ] = kPCA( mat, nBasis )
%KPCA returns a matrix 'basis' whose 'nDim' columns contain the orthonormal basis
%for the distance matrix given by 'mat'.

    [hh, ww] = size(mat);
    
    assert(hh == ww, 'Need a square matrix');
    assert(issymmetric(mat), 'Distances are symmetric');
    
%     % Only for RBF kernel
%     test for unit diagonal elements
%     eyehh = eye(hh);
%     test = mat .* mat;
%     assert(test == eyehh, 'Diagonal elements must be one')

    % center matrix
    avgMat = ones(hh) / hh;
    centerMat = mat - mat*avgMat - avgMat*mat + avgMat*mat*avgMat;
    
    % take nBasis eigenvalues
    [V, S, ~] = svd(centerMat);
    [~, idx] = sort(diag(S), 'descend');
    
    S = S(idx, idx);
    V = V(:, idx);
    
    V = V(:, 1:nBasis);
    S = sum(S, 1); % get an array of eigenvalues
    S = S(1:nBasis);
    V = V ./ sqrt(S);

    basis = V;
end

