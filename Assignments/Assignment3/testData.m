%% Test Data
data_box = [1, 1; -1 -1; 1 -1; -1, 1];
data_box = [cos(pi/6) -sin(pi/6);
           sin(pi/6) cos(pi/6)] * data_box';
       
data_parallel = [-1, -1;
                   0, 0;
                   1, 1;
                  -1, 0;
                   0, 1;
                   1, 2];
data_antiparallel = [data_parallel(:, 1), -data_parallel(:, 2)];

% 8 vertices of a cube
Box = [-1 -1 -1; 1 1 1; 1 1 -1;
       -1 1 1 ; -1 -1 1; -1 1 -1;
        1 -1 -1; 1 -1 1];

bunny = V(:, 1:2);

% Split bunny
[bunnyHeight, dim]= size(V);
splitBunny = bunny;
splitPt = fix(bunnyHeight/3);

splitBunny(1:splitPt, 1) = splitBunny(1:splitPt, 1) + 0.2* ones(splitPt, 1);

% Gaussian
mu = [3,4];
sigma = [1 0.1; 0.1 1];

rng default  % For reproducibility
r = mvnrnd(mu,sigma,40);

% Hald
load hald;
toy = hald(:, 1:3);