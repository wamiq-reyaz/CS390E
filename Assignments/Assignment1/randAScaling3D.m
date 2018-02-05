function A = randAScaling3D()
    A = eye(3);
    A(1, :)  = A(1, :) * rand_1_5();
    A(2, :)  = A(2, :) * rand_1_5();
    A(3, :)  = A(3, :) * rand_1_5();
end
