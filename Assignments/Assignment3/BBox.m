function [ ur, ll, pc, eigen, center] = BBox( pointCloud )
%BBOX Returns the Object Oriented Bounding Box in world coordinates
%   Computes the extent of the Object Oriented Bounding Box using SVD

    assert(ismatrix(pointCloud), 'Must be atleast a 2D point cloud');
    
    [numPoints, dim] = size(pointCloud);
    assert(dim == 2 || dim == 3, 'Only two and three dimensions supported'); % dont ask why
      
    % center matrix
    center =  zeros(dim, 1);
    for ii=1:dim
        center(ii) = sum(pointCloud(:, ii)) / numPoints;
        pointCloud(:, ii) = pointCloud(:, ii) - center(ii);
    end    
    %pointCloud = pointCloud - mean(PointCloud);
    
    % find PCA axis 
    [pc, S, ~] = svd(pointCloud');
    
    eigen = zeros(dim, 1);
    for ii=1:dim
        eigen(ii) = S(ii, ii);
    end
    
    % project onto principal components
    projectedPoints = pointCloud * pc;
    
    % determine bounding box dimensions
    if(dim == 2)
       ur = zeros(2, 1);
       ll = zeros(2, 1);
    else
       ur = zeros(3, 1);
       ll = zeros(3, 1);
    end
    
    for ii=1:dim
       ur(ii) = max(projectedPoints(:, ii)); 
       ll(ii) = min(projectedPoints(:, ii));
    end
    
%% %% Tests
    % TODO: Should be a separate file
    
    % All points must be inside the box
    assert(ur(1) >= max(projectedPoints(:, 1)));
    assert(ur(2) >= max(projectedPoints(:, 2)));
    
    assert(ll(1) <= max(projectedPoints(:, 1)));
    assert(ll(1) <= max(projectedPoints(:, 2)));
    
    if(dim == 3)
        assert(ur(3) >= max(projectedPoints(:, 3)));
        assert(ll(3) <= max(projectedPoints(:, 3))); 
    end
end
