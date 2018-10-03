function [ areaMat, meanMat ] = meanArea( faces, vertices )
%COTAREA(F,V) returns the components for calculating the cotangent laplacian 
%   AREAMAT(I,I) has the local area of the vertices on the diagonals
%   COTMAT(I,J) gives the cotangent matrix on the edge connecting vertices
%   i and j

    [numFaces, dimFaces] = size(faces);
    [numVertices, dimVertices] = size(vertices);
    assert(numFaces > 0);
    assert(numVertices > 0);
    
    assert(dimVertices == 3);
    assert(dimFaces == 3); % only triangle meshes

    idx1 = faces(:, 1);
    idx2 = faces(:, 2);
    idx3 = faces(:, 3);
    
    % the edge opposite the vertex
    e1 = vertices(idx3, :) - vertices(idx2, :);
    e2 = vertices(idx1, :) - vertices(idx3, :);
    e3 = vertices(idx2, :) - vertices(idx1, :);
    
    % cot(x, y) = dot(x,y)/ cross(x,y)
    % vecnorm not avaliable in MATLAB 2016
    cot1 = -dot(e3, e2, 2) ./ veclen(cross(e3, e2, 2), 2);
    cot2 = -dot(e3, e1, 2) ./ veclen(cross(e3, e1, 2), 2);
    cot3 = -dot(e1, e2, 2) ./ veclen(cross(e1, e2, 2), 2);
    
    % length
    l1 = veclen(e1, 2);
    l2 = veclen(e2, 2);
    l3 = veclen(e3, 2);
    
    % half-tangent at the vertex = sinx/ 91 + cos x
    tan1 = -veclen(cross(e1, e2, 2), 2) ./ (1 + dot(e1, e2, 2));
    tan2 = -veclen(cross(e3, e1, 2), 2) ./ (1 + dot(e3, e1, 2));
    tan3 = -veclen(cross(e3, e2, 2), 2) ./ (1 + dot(e3, e2, 2)) ;
    
    % constructors for sparse
    ii = [idx1,     idx2,     idx2,     idx3,     idx3,     idx1];
    jj = [idx2,     idx1,     idx3,     idx2,     idx1,     idx3];
    v  = [tan1./l3, tan2./l3, tan2./l1, tan3./l1, tan3./l2, tan1./l2]; % tangent wieghted by length
    
    meanMat = sparse(ii, jj, v);
    
    % make diagonal elements non zero
    diagElem = sum(meanMat, 2);
    idx = 1:numVertices;
    diagSparse = sparse(idx, idx, diagElem);
    meanMat = meanMat - diagSparse;
    
    
    
    % Area matrix
    % from http://www.geometry.caltech.edu/pubs/DMSB_III.pdf
    % Triangle areas from https://www.cs.cmu.edu/~kmcrane/Projects/Other/TriangleAreasCheatSheet.pdf
    area1 = 0.125 * (cot2 .* veclen2(e2) + cot3 .* veclen2(e3));
    area2 = 0.125 * (cot3 .* veclen2(e3) + cot1 .* veclen2(e1));
    area3 = 0.125 * (cot1 .* veclen2(e1) + cot2 .* veclen2(e2));
    
    
    triArea = 0.5 * veclen(cross(e1, e2, 2), 2);
    cotVtxArray = [cot1, cot2, cot3];
    for vtx=1:3
        cotVtx = cotVtxArray(: , vtx);
        obtuseIdx = find(cotVtx < 0);

        if vtx == 1
            weight = [0.5 0.25 0.25]; % 1 is obtuse, give it more weight
        elseif vtx == 2
            weight = [0.25 0.5 0.25];
        else 
            weight = [0.25 0.25 0.5];
        end
          
        area1(obtuseIdx) = triArea(obtuseIdx) * weight(1);
        area2(obtuseIdx) = triArea(obtuseIdx) * weight(2);
        area3(obtuseIdx) = triArea(obtuseIdx) * weight(3);
    end
    
    sz = [numVertices, 1]; % size of area 
    area = accumarray(idx1, area1, sz) + accumarray(idx2, area2, sz) + accumarray(idx3, area3, sz);
    areaMat = sparse(idx, idx, area);
end

