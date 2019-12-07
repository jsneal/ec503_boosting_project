function boundary = decision_boundary(data,alphas,classifiers)
% Function that plots the decision boundaries

% Inputs
%       data_train: trainin set of  a dataset(n rows (samples) and d+1 columns (d features + labels))
%       alphas: weight of each weak classifier
%       classifiers: all of the best classifiers

% Output
%       boundary: not used

[maximum_x1,~] = max(data(:,1));
[minimum_x1,~] = min(data(:,1));
[minimum_x2,~] = min(data(:,2));
[maximum_x2,~] = max(data(:,2));

dense_grid_x1 = (floor(minimum_x1)-.01):.01:ceil(maximum_x1)+.01;
dense_grid_x2 = (floor(minimum_x2)-.01):.01:ceil(maximum_x2)+.01;
num_of_points = length(dense_grid_x1)^2;
dense_grid_1 = zeros(num_of_points, 3);
dense_grid_2 = zeros(num_of_points, 3);
start_i = 1;
step = length(dense_grid_x1);
end_i = length(dense_grid_x1);

for i = 1:length(dense_grid_x1)
    dense_grid_1(start_i:end_i, 1) = dense_grid_x2(i).*ones(1,step);
    dense_grid_1(start_i:end_i, 2) = dense_grid_x1;
    dense_grid_2(start_i:end_i, 2) = dense_grid_x2(i).*ones(1,step);
    dense_grid_2(start_i:end_i, 1) = dense_grid_x1;
    start_i = end_i+1;
    end_i = end_i+step;
end

for i=1:size(dense_grid_1,1)
    dense_grid_1(i,3) = decision([dense_grid_1(i,1),dense_grid_1(i,2)], alphas, classifiers);
    dense_grid_2(i,3) = decision([dense_grid_2(i,1),dense_grid_2(i,2)], alphas, classifiers);
end

boundary=[];
for i=2:size(dense_grid_1,1)
    if (dense_grid_1(i,3) ~= dense_grid_1(i-1,3))
        boundary = [boundary; (dense_grid_1(i-1,1)+dense_grid_1(i,1))/2, (dense_grid_1(i-1,2)+dense_grid_1(i,2))/2 ];
    end
end
for i=2:size(dense_grid_2,1)
    if (dense_grid_2(i,3) ~= dense_grid_2(i-1,3))
        boundary = [boundary; (dense_grid_2(i-1,1)+dense_grid_2(i,1))/2, (dense_grid_2(i-1,2)+dense_grid_2(i,2))/2 ];
    end
end

figure; hold on;
gscatter(data(:,1),data(:,2),data(:,3),'rb','+o');
plot(boundary(:,1),boundary(:,2),'.','MarkerSize',10);

boundary=1;
end

