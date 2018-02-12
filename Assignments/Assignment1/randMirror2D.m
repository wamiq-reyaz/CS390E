%% randMirror2D.m
%% Author: Wamiq Reyaz, VCC, KAUST

function mat = randMirror2D()
 choices = [ 
            [-1, 0, 0 1],
            [1, 0, 0, -1]
           ];
choice = randi(2, 1);
mat = choices(choice, :);

mat = reshape(mat, 2, 2);
end