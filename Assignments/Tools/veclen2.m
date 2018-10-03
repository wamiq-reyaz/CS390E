function [ len ] = veclen2( input )
%VECLEN returns vector lengths for input in matrix
    len = sum(input .^2, 2);
end
