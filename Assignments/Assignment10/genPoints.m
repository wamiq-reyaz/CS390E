function [ xx, yy, hh, ww ] = genPoints( msize, nsize, method )
%GENPOINTS Summary of this function goes here
    X_JITTER = 0.2;
    Y_JITTER = 0.1;
    
    HEIGHT = 0.5;
    WIDTH = 0.6;
    H_JITTER = 0.02;
    W_JITTER = 1/60;

    switch method
        case 'bl' % bottom left
            xx = (1:nsize)';
            xx = repmat(xx, msize, 1);
            xx = xx + randn(msize*nsize, 1) * X_JITTER;

            yy = (1:msize)';
            yy = repmat(yy, 1, nsize)';
            yy = yy(:);
            yy = yy + randn(msize*nsize, 1) * Y_JITTER;

            hh = HEIGHT + rand()*H_JITTER;
            ww = WIDTH + rand()*W_JITTER;
        otherwise
            error('Not implemented');
    end


end

