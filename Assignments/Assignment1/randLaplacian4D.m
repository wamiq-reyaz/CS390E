%% randLaplacian4D
%% Author: Wamiq Reyaz, VCC, KAUST

function mat = randLaplacian4D()
    size = 4;
    adjacency = sprand(size, size, size); % a sparse matrix
    adjacency = adjacency' * adjacency;
    
    G = graph(adjacency, 'OmitSelfLoops');
    mat = laplacian(G);
end