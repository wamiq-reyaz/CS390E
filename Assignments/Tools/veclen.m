function [ len ] = veclen( input, dim )
%VECLEN returns vector lengths for input in matrix
    len = sqrt(sum(input .^2, dim));
end

