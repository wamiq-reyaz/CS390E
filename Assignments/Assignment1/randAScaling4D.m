function A = randAScaling4D()    
    A = eye(4);
    A(1, :)  = A(1, :) * rand_1_5();
    A(2, :)  = A(2, :) * rand_1_5();
    A(3, :)  = A(3, :) * rand_1_5();
end

