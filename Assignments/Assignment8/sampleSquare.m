function [ points ] = sampleSquare( center, side, nSamples )
%SAMPLESQUARE 
    X0 = center(1); Y0 = center(1);
    
    % horiz
    X1 = X0 - side + rand(1, nSamples)* 2*side;
    Y1 = ones(size(X1)) * side ;
    Y1 = Y0 + Y1 + rand(size(Y1));

    X2 = X0 - side + rand(1, nSamples)*2* side;
    Y2 = ones(size(X1)) * -side;
    Y2 = Y0 + Y2 + rand(size(Y2));
    
    % vert
    Y3 = Y0 - side + rand(1, nSamples)*2*side;
    X3 = ones(size(Y3)) * side;
    X3 = X0 + X3 + rand(size(X3));

    Y4 = Y0 - side + rand(1, nSamples)*2*side;
    X4 = ones(size(Y4)) * -side;
    X4 = X0 + X4 + rand(size(X4));

    X = [X1 X2 X3 X4];
    Y = [Y1 Y2 Y3 Y4];
    
    points = [X;Y]';
end

