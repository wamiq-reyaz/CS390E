function [ ] = plotPCA( input, pc, eigen, center)
%PLOTPCA Summary of this function goes here
%   Detailed explanation goes here
    figure('name', 'PCA')
    scatter(input(:, 1), input(:, 2));
        
    hold on;
    lineEnd1 = center + pc(:, 1);
    lineEnd2 = center + pc(:, 2);
    
    X = [center(1), lineEnd1(1);
          center(1), lineEnd2(1)];
    
    Y = [center(2), lineEnd1(2);
          center(2), lineEnd2(2)];
      
    line(X',Y', 'linewidth', 2);
    set(gca,'DataAspectRatio',[1 1 1])
    
end

