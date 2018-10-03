X = [-216.67,-33.221; -213.67,-27.221; -211.67,-2.2214; -209.67,84.779;
-200.67,87.779; -197.67,-11.221; -197.67,44.779; -191.67,-47.221;
-177.67,-119.22; -176.67,-118.22; -172.67,-116.22; -171.67,165.78;
-140.67,-168.22; -126.67,202.78; -125.67,201.78; -123.67,201.78;
-122.67,201.78; -116.67,31.779; -114.67,-27.221; -113.67,221.78;
-110.67,-33.221; -98.672,-9.2214; -94.672,-32.221; -93.672,84.779;
-90.672,49.779; -88.672,84.779; -87.672,-236.22; -86.672,36.779;
-78.672,54.779; -78.672,230.78; -76.672,54.779; -67.672,105.78;
-57.672,-100.22; -53.672,-122.22; -51.672,-146.22; -51.672,96.779;
-47.672,-269.22; -46.672,-136.22; -46.672,-134.22; -28.672,-281.22;
-28.672,-148.22; -28.672,128.78; -19.672,-16.221;
-18.672,-31.221; -18.672,-28.221; -16.672,129.78; -15.672,11.779;
-15.672,150.78; -15.672,151.78; -13.672,3.7786; -11.672,25.779;
-9.6718,-22.221; -9.6718,-21.221; -9.6718,-0.22137; -8.6718,-41.221;
-8.6718,12.779; -7.6718,-28.221; -5.6718,129.78; -3.6718,-35.221;
-2.6718,-14.221; -0.67176,-250.22; 3.3282,16.779; 7.3282,-4.2214;
8.3282,-4.2214; 8.3282,5.7786; 8.3282,127.78; 11.328,-41.221;
11.328,34.779; 12.328,-127.22; 12.328,252.78; 13.328,-39.221;
13.328,253.78; 14.328,-128.22; 16.328,-10.221; 16.328,-9.2214;
16.328,32.779; 16.328,33.779; 18.328,-164.22; 18.328,24.779;
20.328,22.779; 21.328,-0.22137; 21.328,8.7786; 21.328,143.78;
21.328,144.78; 22.328,-40.221; 22.328,-21.221; 26.328,-46.221;
26.328,-13.221; 27.328,-33.221; 27.328,123.78; 30.328,-13.221;
34.328,-22.221; 34.328,139.78; 38.328,18.779; 40.328,1.7786;
40.328,2.7786; 40.328,135.78; 43.328,31.779; 44.328,-40.221;
45.328,-28.221; 45.328,-16.221; 48.328,-156.22; 56.328,262.78;
59.328,-271.22; 62.328,-243.22; 63.328,251.78; 75.328,121.78;
79.328,-245.22; 80.328,90.779; 83.328,105.78; 86.328,126.78;
97.328,-118.22; 115.33,-89.221; 116.33,-76.221; 116.33,-40.221;
118.33,-230.22; 125.33,-79.221; 128.33,-30.221; 140.33,-217.22;
142.33,-230.22; 146.33,-208.22; 169.33,179.78; 174.33,150.78;
214.33,142.78; 221.33,71.779; 223.33,-65.221; 226.33,-24.221;
230.33,-27.221; 233.33,-11.221; 235.33,-86.221; 241.33,7.7786];

N=size(X, 1);

color = zeros(N,3);
for i = 1:N
    if( norm(X(i,:),2) < 60)
        color(i, :) = [1 0 0];
    elseif( norm(X(i,:),2) < 170) 
        color(i, :) = [0 1 0];
    else
        color(i, :) = [0 0 1];
    end
end

red = find(all(bsxfun(@eq, color, [1 0 0]), 2));
green = find(all(bsxfun(@eq, color, [0 1 0]), 2));
blue = find(all(bsxfun(@eq, color, [0 0 1]), 2));

scatter(X(:, 1), X(:,2), N, color, 'filled'); alpha(0.50); 


%% Compute Kernel PCA
%% - choose the bandwith parameter 
%% - save 50 or more result plots for different bandwidth parameters in a file
%% - color the points according to the clusters
%% - create your own test data by sampling random points in three squares (similar to the three circles)
%%   and also save 50+ plots for different bandwidth

bandwidthList = [0.00001]; 

for ii = 1:length(bandwidthList)
    Bandwidth = bandwidthList(ii);
    
    distMat = rbfMat(X, Bandwidth);
    bases = kPCA(distMat, 3);
    projPts = distMat * bases;
    
    figure();title(num2str(Bandwidth)); 
    scatter3(projPts(red, 1), projPts(red,2), projPts(red, 3), N, color(red, :), 'filled'); alpha(0.50); hold on;
    scatter3(projPts(green, 1), projPts(green,2), projPts(green,3), N, color(green, :), 'filled'); alpha(0.50); hold on;
    scatter3(projPts(blue, 1), projPts(blue,2),  projPts(blue,3), N, color(blue, :), 'filled'); alpha(0.50); 
    grid minor;
    
%     scatter(projPts(red, 1), projPts(red,2), N, color(red, :), 'filled'); alpha(0.50); hold on;
%     scatter(projPts(green, 1), projPts(green,2), N, color(green, :), 'filled'); alpha(0.50); hold on;
%     scatter(projPts(blue, 1), projPts(blue,2), N, color(blue, :), 'filled'); alpha(0.50); hold on;
    
    filename = ['fig/ProjectedPoints_' num2str(Bandwidth) '.png'];
    saveas(gcf, filename)
    
end

%% Square data
rng(42); % for reproducibility

U = sampleSquare([0,0], 15, 20);
V = sampleSquare([0,0], 30, 20);
W = sampleSquare([0,0], 45, 20);
data = [U; V; W];

[N, ~] = size(data);
color = zeros(N,3);
for i = 1:N
    if( norm(data(i,:),Inf) < 16)
        color(i, :) = [1 0 0];
    elseif( norm(data(i,:), Inf) < 32) 
        color(i, :) = [0 1 0];
    else
        color(i, :) = [0 0 1];
    end
end

red = find(all(bsxfun(@eq, color, [1 0 0]), 2));
green = find(all(bsxfun(@eq, color, [0 1 0]), 2));
blue = find(all(bsxfun(@eq, color, [0 0 1]), 2));
figure();
scatter(data(:, 1), data(:, 2), N,  color, 'filled'); alpha 0.5;
%%

bandwidthList = [0.00088]; 

for ii = 1:length(bandwidthList)
    Bandwidth = bandwidthList(ii);
    
    distMat = rbfMat(data, Bandwidth);
    bases = kPCA(distMat, 3);
    projPts = distMat * bases;
    
    figure();title(num2str(Bandwidth));    
    scatter3(projPts(red, 1), projPts(red,2), projPts(red, 3), N, color(red, :), 'filled'); alpha(0.50); hold on;
    scatter3(projPts(green, 1), projPts(green,2), projPts(green,3), N, color(green, :), 'filled'); alpha(0.50); hold on;
    scatter3(projPts(blue, 1), projPts(blue,2),  projPts(blue,3), N, color(blue, :), 'filled'); alpha(0.50); hold on;
    grid minor;
    filename = ['fig/ProjectedPoints_' num2str(Bandwidth) '.png'];
    saveas(gcf, filename)
    
end
