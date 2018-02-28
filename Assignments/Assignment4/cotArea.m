function [ areaMat, cotMat ] = cotArea( faces, vertices )
%COTAREA returns the components for calculating the cotangent laplacian 
%   AREAMAT(I,I) has the local area of the vertices on the diagonals
%   COTMAT(I,J) gives the cotangent matrix on the edge connecting vertices
%   i and j

    [numFaces, dimFaces] = size(faces);
    [numVertices, dimVertices] = size(vertices);
    assert(numFaces > 0);
    assert(numVertices > 0);
    
    assert(dimVertices == 3);
    assert(dimFaces == 3); % only triangle meshes

    idx1 = faces(:, 1)';
    idx2 = faces(:, 2)';
    idx3 = faces(:, 3)';
    
    v1 = vertices(idx3, :) - vertices(idx2, :);
    v2 = vertices(idx1, :) - vertices(idx3, :);
    v3 = vertices(idx2, :) - vertices(idx1, :);
    
    % compute area using cross product
    normals = cross(v1, v2, 2);
%     areaMat = sparse(vecnorm(normals, 2));
%     does NOT work with v2016
    
    areaMat = sum(normals.^2, 2); % sum up along rows
    areaMat = sparse(diag(areaMat));
    cotMat = zeros(1);
end

