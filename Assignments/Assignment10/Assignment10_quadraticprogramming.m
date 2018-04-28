% How to parametrize a rectangle?
% - lower left corner, width, height
% - center point, width, height
% - center point, half width, half height
% - lower left corner, upper right corner
% constraints
% - alignment
% - same size
% - same spacing

% Objective:
% quadratic objective
% (x1 - x1input)^2 + (y1 - y1input)^2 ...
% 
% Input
% compute a grid of m x n rectangles that are approximately at regular grid positions + some noise.

msize = 3;
nsize = 5;

% plot the resulting grid of rectangles


% Output
% list of rectangles that is properly constrained
% Make an example with 
% - same spacing
% - top aligned in a row of rectangles
% - all have the same size
% - left aligned within a column
% - all of the constrains above combined

% Look at some matlab solvers. List a set of possible solvers and try one.
% quadprog and lsqlin will work.