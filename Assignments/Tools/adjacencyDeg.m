function [ adjacency, degree ] = adjacencyDeg( faces)
%ADJACENCY Returns the adjacency matrix
%   [adjacency, degree] = ADJACENCYDEG(faces, numVertices) Computes the adjacency matrix from a list of faces.
%   Also returns the degree of each vertex
    
    [numFaces, dim] = size(faces);
    assert(numFaces > 0);
    assert(dim == 3);

    v1 = faces(:, 1);
    v2 = faces(:, 2);
    v3 = faces(:, 3);
    
    % Here is the logic for this. Every edge appears in the  constructor
    % twice for two triangles it connects. So we divide the value by 2. The
    % constructor for sparse simply adds duplicates. 0.5*2 = 1 and we are
    % done
    
    % constructors for sparse
    ii = [v1 v2,  v1 v3,  v2, v3];
    jj = [v2 v1,  v3 v1,  v3, v2];
    vv = ones(numFaces, 6) / 2;
    
    adjacency = sparse(ii, jj, vv);
    degree = diag(sum(adjacency, 2));
end

