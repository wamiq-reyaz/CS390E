%% randMirror3D.m
%% Author: Wamiq Reyaz, VCC, KAUST

function mat = randMirror3D()
 choices = [ 
            [-1, 0, 0, 0, 1, 0, 0, 0, 1],
            [1, 0, 0, 0, -1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1, 0, 0, 0, -1]
           ];
choice = randi(3, 1);
mat = choices(choice, :);

mat = reshape(mat, 3, 3);
end