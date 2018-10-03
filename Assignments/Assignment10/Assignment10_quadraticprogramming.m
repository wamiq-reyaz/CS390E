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
clc; close all; clear;

msize = 3;
nsize = 5;
%%
options.rows = msize;
options.cols = nsize;

%%
[xx, yy, ww, hh] = genPoints(msize, nsize, 'bl');

%%
save('points', 'xx', 'yy', 'ww', 'hh')

%%
[~,h1,~] = showWin(xx, yy, hh, ww, [], []); 
%%
% export_fig(h1, 'window.png')

%% with lower point and fixed height, width
% Set up system
options.type = 'VBFHFW';
[Aeq, beq, ~, ~] = genConstr(xx, yy, hh, ww, options);

% Allot matrices
H = 0.5*eye(length(xx));
f = -xx;

% solve system
[oCood, fval] = quadprog(H, f, [], [], Aeq, beq);

xnew = oCood;
% show windows
[~,~,~] = showWin(xx, yy, hh, ww, xnew, []);
%%
% export_fig 'eqSpace.png'
%% lower point with no overlap constraint
% Set up system
options.type = 'VBFHFWNO';
[Aeq, beq, Aineq, bineq] = genConstr(xx, yy, hh, ww, options);

% Allot matrices
H = 0.5*eye(length(xx));
f = -xx;

% solve system
[xnew, fval] = quadprog(H, f, Aineq, bineq, Aeq, beq);

% show windows
[~,~,~] = showWin(xx, yy, hh, ww, xnew, []);
%% wtih lower and upper points
% Set up system
options.type = 'VBVUFHFW';
[Aeq, beq, Aineq, bineq] = genConstr(xx, yy, hh, ww, options);

% Allot matrices
H = eye(2*length(xx));
f = -[xx;xx + ww];

% solve system
[oCood, fval] = quadprog(H, f, [], [], Aeq, beq);

% Compute new bottom points and new width
xnew = oCood(1:length(xx));
ww = oCood(length(xx)+1:end) - xx;

% show windows
[h, h1, h2] = showWin(xx, yy, hh, ww, xnew, []);

%% Upper, Lower with top aligned in a row
options.type = 'FBVUFHFWTA';
[Aeq, beq, Aineq, bineq] = genConstr(xx, yy, hh, ww, options);

% Allot matrices
H = eye(length(yy));
f = -(yy + hh);

% solve system
[oCood, fval] = quadprog(H, f, [], [], Aeq, beq);

% Compute new top points and new height
ynew = oCood

% show windows
[h, h1, h2] = showWin(xx, yy, hh, ww, [], ynew);
%%
% export_fig 'top.png'
%% Upper Lower, with left aligned in column
options.type = 'VBFUFHFWLA';
[Aeq, beq, Aineq, bineq] = genConstr(xx, yy, hh, ww, options);

% Allot matrices
H = eye(length(yy));
f = -xx;

% solve system
[oCood, fval] = quadprog(H, f, [], [], Aeq, beq);

% Compute new top points and new height
xnew = oCood

% show windows
[h, h1, h2] = showWin(xx, yy, hh, ww, xnew, []);
%%
% export_fig 'left.png'

%% All
% Set up system
options.type = 'VBVUFHFW';
[Aeq, beq, Aineq, bineq] = genConstr(xx, yy, hh, ww, options);

% Allot matrices
H = eye(2*length(xx));
f = -[xx;xx + ww];

% solve system
[oCood, fval] = quadprog(H, f, [], [], Aeq, beq);

% Compute new bottom points and new width
xnew = oCood(1:length(xx));
ww = oCood(length(xx)+1:end) - xx;

[h, h1, h2] = showWin(xx, yy, hh, ww, xnew, []);

%% Upper, Lower with top aligned in a row
options.type = 'FBVUFHFWTA';
[Aeq, beq, Aineq, bineq] = genConstr(xx, yy, hh, ww, options);

% Allot matrices
H = eye(length(yy));
f = -(yy + hh);

% solve system
[oCood, fval] = quadprog(H, f, [], [], Aeq, beq);

% Compute new top points and new height
ynew = oCood

% show windows
[h, h1, h2] = showWin(xnew, yy, hh, ww, [], ynew);

%% Upper Lower, with left aligned in column
options.type = 'VBFUFHFWLA';
[Aeq, beq, Aineq, bineq] = genConstr(xx, yy, hh, ww, options);

% Allot matrices
H = eye(length(yy));
f = -(xx + ww);

% solve system
[oCood, fval] = quadprog(H, f, [], [], Aeq, beq);

% Compute new top points and new height
xnew = oCood

% show windows
[h, h1, h2] = showWin(xx, yy, hh, ww, xnew, []);

%%
% export_fig 'sameTop.png'
%% generate points

%% generate constraints

%% solve system

%% plot



% show windows
% [h, h1, h2] = showWin(x, y, hh, ww, xnew, []);
% eqaxsp([h1, h2], [-0.5 nsize -0.25 msize-0.25]);


% Output
% list of rectangles that is properly constrained
% Make an example with 
% - same spacing
% - top aligned in a row of rectangles
% - all have the same size
% - left aligned within a column
% - all of the constrains above combined


% Look at some matlab solvers. List a set of possible solvers and try one.
% quadprog and lsqlin will work









