function [ ] = vizLaplacian( V, L, scale)
%VIZLAPLACIAN Visualize the laplacian of a mesh

    quiver3(V(:, 1), V(:, 2), V(:, 3), -L(:, 1), -L(:, 2), -L(:, 3), scale);
    quiver3(V(:, 1), V(:, 2), V(:, 3), L(:, 1), L(:, 2), L(:, 3), scale);
    legend('', 'Inverted', 'Original');
    camva(180)
    axis off;

end

