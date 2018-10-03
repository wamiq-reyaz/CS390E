function [ output ] = mds( data, dim )
%MDS Returns the mds output in the rows of 'output'.

    [nPoints, ~] = size(data);

    % calculate distance matrix
    dist = pdist(data);
    dist = squareform(dist);
    
    % centering matrix
    avgMat = 1/nPoints * ones(nPoints);
    cenMat = eye(nPoints) - avgMat;
    
    % double centerin
    B = -0.5*cenMat*dist*cenMat;
    [U, S, ~] = svd(B);
    
    % choose the number of dim
    U = U(:, 1:dim);
    S = S(:, 1:dim);
    S = sum(S, 1);

    output = U .* sqrt(S);
end

