
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

X = [-5 1; -4 2; -3.5 1; -2 -1; -1 5; 0 5; 1 3; 2 3; 4 7; 4.5 8];

X1 = [-5 1; -3.51 2; -3.5 1; -2 4; -1 5; 0.95 5; 1 3; 2 3; 4 7; 4.5 4];

figure('name','2D input points');
Xcoords = X(:, 1);
Ycoords = X(:, 2);
plot( Xcoords, Ycoords, 'o');

p = polyfit(Xcoords, Ycoords, 9);

XcoordsFine = linspace(-5.2, 5.02, 100);

Ypoly = polyval(p, XcoordsFine);

hold on;
plot( XcoordsFine, Ypoly );


% The model we are assuming is a size(X) - 1 polynomial model
% In a linear regression setting, W'x = y. The closed form solution to this
% is W = pinv(x)y. Now we just need to set up the features x as polynomial
% features

[num_samples, dim] = size(X);
poly_degree = num_samples - 1;

raw_features = X(:, 1);
targets = X(:, 2);
features = zeros(num_samples, num_samples);

% create polynomial features
for col=1:num_samples 
    features(:, col) = raw_features .^ (col - 1);
end

poly_coeff = pinv(features) * targets;
poly_coeff = flipud(poly_coeff); % polyval expects coeffs in decreasing powers

prediction = polyval(poly_coeff, XcoordsFine);
plot(XcoordsFine, prediction);
legend('Input points', 'polyfit result', 'regression result');
l2_diff = norm(prediction - Ypoly);
title(['L2 difference: ', num2str(l2_diff, 3)]);




