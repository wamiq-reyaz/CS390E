
%% **********************************************************************
% Reading
% General reading about linear algebra: 
% Read page 23 to page 46 of Matrix Methods in Data Mining and Pattern
% Recognition, Elden

%% **********************************************************************
% Reading
% Read Regression notes in Bishop "Pattern Recognition and Machine Learning" chapter 1.1 (page 4 - page 12)

%% **********************************************************************
% Polynomial fitting
% Given are a set of n points X in 2D
% Fit a polynomial of degree n-1 by solving a linear system. Currently, the
% linear system is solved using polyfit. I would like you to replace the
% built in polyfit function and manually setup the linear system that
% computes the correct polynomial coefficients.
%
% try this for the point set X and X1

X = [-5 1; -4 2; -3.5 1; -2 -1; -1 5; 0 5; 1 3; 2 3; 4 7; 4.5 8]'

X1 = [-5 1; -3.51 2; -3.5 1; -2 4; -1 5; 0.95 5; 1 3; 2 3; 4 7; 4.5 4]'

figure('name','2D input points');
Xcoords = X(1, :);
Ycoords = X(2, :);
plot( Xcoords, Ycoords, 'o');

p = polyfit(Xcoords, Ycoords, 9)

XcoordsFine = linspace(-5.2, 5.02, 100);

Ypoly = polyval(p, XcoordsFine);

hold on;
plot( XcoordsFine, Ypoly );


