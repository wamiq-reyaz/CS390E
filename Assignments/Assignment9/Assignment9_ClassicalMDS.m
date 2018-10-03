%% **********************************************************************
%% Generate random point cloud
%% - generate NumPoints points, randomly scale the axis and randomly rotate the points

NumPoints = 20;
dimensions = 2;

rng(42);

X = rand(NumPoints, dimensions+1);
names = {"Diagon Alley", "The Leaky Cauldron", ...
        "Flourish and Blotts", "Gringotts", ...
        "Magical Menagerie", "Ollivanders", ...
        "Weasleys Wizard Wheezes", ...
        "Godrics Hollow", "Chamber of Secrets", ...
        "The Forbidden Forest", "Hagrids Hut", ...
        "Room of Requirement", "Knockturn Alley", ...
        "Borgin and Burkes", "Little Hangleton", ...
        "House of Gaunt", "Riddle Manor", "Malfoy Manor", ...
        "Ministry of Magic", "Spinners End"};
    
% names = num2str((1:NumPoints)');
color = random_color(NumPoints, 'Pastel');

%% - Plot the first two dimensions of the data
figure()
scatter3(X(:, 1), X(:, 2), X(:, 3), NumPoints, color, 'filled'); alpha(0.5);
text(X(:, 1) + 0.01, X(:, 2), X(:, 3), names(ii), 'Color', color(ii, :));
%% - Compute classical MDS using your own implementation
final = mds(X, 2);
figure(); title('MY implementation');
scatter(final(:,1),final(:,2), NumPoints, color, 'filled'); alpha(0.5);
text(final(:, 1) + 0.01, final(:, 2), names);

%% - Compute classical MDS using the built in matlab code
D = pdist(X);
[Y, eigvals] = cmdscale(D);

Dtriu = D(find(tril(ones(10),-1)))';
maxrelerr = max(abs(Dtriu-pdist(Y(:,1:2))))./max(Dtriu);

figure();  title('MATLAB implementation');
scatter(Y(:,1),Y(:,2), NumPoints, color, 'filled'); alpha(0.5);
text(Y(:, 1) + 0.01, Y(:, 2), names);
xlabel('Harry')
ylabel('Potter')
%% - Visually compare the results
%% you need to somehow randomly color the points to make the results match
