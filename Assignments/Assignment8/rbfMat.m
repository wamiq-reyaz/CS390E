function [ mat ] = rbfMat( data, param )
%RBFMAT Returns the RBF kernel matrix for data with the bandwidth parameter
%'param'
    [nSamples, dim] = size(data);
    
    assert(nSamples > 0, 'empty dataset');
    assert(dim > 0, 'dim miust be greater than 0');
    
    % center input
    data = data - mean(data);
    
    mat = zeros(nSamples);
    % first find norm the diffetence
    for ii=1:nSamples
       mat(ii, :) = veclen(data - data(ii, :) , 2);
    end
    
    % square and exponentiate
    mat = -(mat .* mat) * param;
    mat = exp(mat);
end

