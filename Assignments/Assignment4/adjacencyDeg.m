function [ adjacency, degree ] = adjacencyDeg( faces, numVertices )
%ADJACENCY Returns the adjacency matrix
%   [adjacency, degree] = ADJACENCYDEG(faces, numVertices) Computes the adjacency matrix from a list of faces.
%   Also returns the degree of each vertex
    
    [numFaces, dim] = size(faces);
    assert(numFaces > 0);
    assert(dim == 3);
    
    % ideally begin with a sparse matrix to reduce memory footprint
    adjacency = zeros(numVertices, numVertices);
    for ii = 1:numFaces
       % inefficient as hell
       v1 = faces(ii, 1);
       v2 = faces(ii, 2);
       v3 = faces(ii, 3);
       
       adjacency(v1, v2) = 1;
       adjacency(v2, v3) = 1;
       adjacency(v3, v1) = 1;
       
       adjacency(v2, v1) = 1;
       adjacency(v3, v2) = 1;
       adjacency(v1, v3) = 1;
    end
    
    adjacency = sparse(adjacency);
    degree = diag(sum(adjacency, 2));
end

