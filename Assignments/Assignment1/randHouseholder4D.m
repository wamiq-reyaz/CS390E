function mat = randHouseholder4D()
    mat = eye(4);
    normal = rand(4,1);
    normal = normal / norm(normal);
    mat = mat - 2*(normal*normal');
end
