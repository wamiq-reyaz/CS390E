function [ len ] = veclen( input )
%VECLEN returns vector lengths for input in matrix
    len = sqrt(sum(input .^2, 2));
end

