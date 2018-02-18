function [  ] = plotRectangle( pointMatrix )
%PLOTRECTANGLE Plots a rectangle
%   The columns contain the coordinates of the vertices of the rectangle
    
    [dim, cols] = size(pointMatrix);
    assert(dim == 2 || dim == 3, 'Only 2D/3D points supported');
    assert(cols == 4, 'The 2D points should be in the column of the matrix as [ur, ll, lr, ul]');
    
    
    ur = pointMatrix(:, 1);
    ll = pointMatrix(:, 2);
    lr = pointMatrix(:, 3);
    ul = pointMatrix(:, 4);
    
    if(dim == 2)
       ur(3) = 0;
       ll(3) = 0;
       lr(3) = 0;
       ul(3) = 0;
    end
   
    X = [ll(1), ur(1);
         lr(1), ur(1);
         ur(1), ul(1);
         ul(1), ll(1)];
    
    Y = [ll(2), ur(2);
         lr(2), ur(2);
         ur(2), ul(2);
         ul(2), ll(2)];
     
    Z = [ll(3), ur(3);
         lr(3), ur(3);
         ur(3), ul(3);
         ul(3), ll(3)];
     
    line(X, Y, Z, 'linewidth', 2.2)
    set(gca,'DataAspectRatio',[1 1 1])
    
    if(dim ==3)
        view(3);
    end
end


