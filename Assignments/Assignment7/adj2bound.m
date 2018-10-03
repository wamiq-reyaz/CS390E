function [order, dist ] = adj2bound( adj, V)
%ADJ2BOUND From an adjacency matrix, returns the order and dstances of
% boundary points
    % Find the order of boundary points using DFS
    G = graph(adj);
    [u, ~, ~] = find(adj, 1); % find one connected vertex
    order = dfsearch(G, u(1));
    
    % Find distances
    dist = V(order, :) - V(order(1), :);  %make init origin
    offset = circshift(dist, -1, 1);
    
    dist = veclen(dist - offset, 2);
    dist = cumsum(dist , 1);  % calculate distance cumulatively
    dist = (dist - min(dist)) / (max(dist)); % normalize

end

