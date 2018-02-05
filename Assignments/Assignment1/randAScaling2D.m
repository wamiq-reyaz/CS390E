function A = randAScaling2D()
    A = eye(2);
    A(1, :)  = A(1, :) * rand_1_5();
    A(2, :)  = A(2, :) * rand_1_5();
end
