function [ lF, lV ] = loopSub( F, V )
%LOOPSUB Performs a single iteration of Loop SUbdivision on the mesh
%   The mesh is described as a list of face indices and vertices in both
%   the input and the output
    [nF, dF] = size(F);
    [nV, dV] = size(V);
    assert(nF > 0);
    assert(nV > 0);
    
    assert(dV == 3);
    assert(dF == 3); % only triangle meshes
    
    % vertex ids
    v1 = F(:, 1);
    v2 = F(:, 2);
    v3 = F(:, 3);
    
    % Opposite vertices
    opp = sparse([v2, v3, v1], ...
                 [v3, v1, v2], ...
                 [v1, v2, v3]);
    
    opp1 = triu(opp);  % first opposite vertex
    opp2 = tril(opp)'; % second opposite vertex
    
    [i1, j1, o1] = find(opp1);
    [i2, j2, o2] = find(opp2);
    
    oV = 3/8*(V(i1, :) + V(j1, :)) + ...
         1/8*(V(o1, :) + V(o2, :));
    
    oIdx = (1:length(oV))' + nV;
    % Indices for new faces
    fac = sparse([i1   j2], ...
                 [j1   i2], ...
                 [oIdx oIdx]);
    
    sz = size(fac);
    oF = [v1, fac(sub2ind(sz, v1, v2)), fac(sub2ind(sz, v1, v3)); ...
          v2, fac(sub2ind(sz, v2, v3)), fac(sub2ind(sz, v2, v1)); ...
          v3, fac(sub2ind(sz, v3, v1)), fac(sub2ind(sz, v3, v2)); ...
  
          fac(sub2ind(sz, v1, v2)), fac(sub2ind(sz, v2, v3)), ...
                                    fac(sub2ind(sz, v3, v1))];
    oF = full(oF);
    
    %% Recomputing positions of old vertices
    
    % Adjacency
    ii = [v1,v2  v1,v3  v2,v3];
    jj = [v2,v1  v3,v1  v3,v2];
    vv = ones(nF, 6)/2;
    
    adjacency = sparse(ii, jj, vv);
    
    % Valency
    val = sum(adjacency, 2);
    weight = val;
    % weights for original vertices
    threeIdx = val == 3;
    weight(threeIdx) = 2;
    weight = 3 ./ (8 * weight);
    
    % compute new vertex positions
    % create mask matrix
    mask = weight .* (adjacency) + (1 - val .* weight) .* speye(nV); 
    newV = mask * V;
    
    %%
    lF = oF;
    lV = [newV; oV];
 
end

