function boundary = decision_boundary(data,alphas,classifiers,step)
% Function that plots the decision boundaries

% Inputs
%       data_train: trainin set of  a dataset(n rows (samples) and d+1 columns (d features + labels))
%       alphas: weight of each weak classifier
%       classifiers: all of the best classifiers
%       step: step size for the dense grid

% Output
%      boundary: boundary points

max_x1 = max(data(:,1));
min_x1 = min(data(:,1));
min_x2 = min(data(:,2));
max_x2 = max(data(:,2));

grid_x1 = (floor(min_x1)-.01):step:ceil(max_x1)+.01;
grid_x2 = (floor(min_x2)-.01):step:ceil(max_x2)+.01;
num = length(grid_x1)^2;
dense_grid_1 = zeros(num, 3);
dense_grid_2 = zeros(num, 3);
start_i = 1;
steps = length(grid_x1);
end_i = length(grid_x1);

for i = 1:length(grid_x1)
    dense_grid_1(start_i:end_i, 1) = grid_x2(i).*ones(1,steps);
    dense_grid_1(start_i:end_i, 2) = grid_x1;
    dense_grid_2(start_i:end_i, 2) = grid_x2(i).*ones(1,steps);
    dense_grid_2(start_i:end_i, 1) = grid_x1;
    start_i = end_i+1;
    end_i = end_i+steps;
end

for i=1:size(dense_grid_1,1)
    dense_grid_1(i,3) = decision([dense_grid_1(i,1),dense_grid_1(i,2)], alphas, classifiers);
    dense_grid_2(i,3) = decision([dense_grid_2(i,1),dense_grid_2(i,2)], alphas, classifiers);
end

boundary=[];
for i=2:size(dense_grid_1,1)
    if (dense_grid_1(i,3) ~= dense_grid_1(i-1,3))
        %if( (dense_grid_1(i,2)-dense_grid_1(i-1,2))==step )
            boundary = [boundary; (dense_grid_1(i-1,1)+dense_grid_1(i,1))/2, (dense_grid_1(i-1,2)+dense_grid_1(i,2))/2 ];
        %end
    end
end
for i=2:size(dense_grid_2,1)
    if (dense_grid_2(i,3) ~= dense_grid_2(i-1,3))
        %if( (dense_grid_2(i,1)-dense_grid_2(i-1,1))==step )
            boundary = [boundary; (dense_grid_2(i-1,1)+dense_grid_2(i,1))/2, (dense_grid_2(i-1,2)+dense_grid_2(i,2))/2 ];
        %end
    end
end

figure; hold on;
gscatter(data(:,1),data(:,2),data(:,3),'rb','+o');
plot(boundary(:,1),boundary(:,2),'.','MarkerSize',10);
legend('-1','1','Boundary'); xlabel('Feature 1'); ylabel('Feature 2');

end

