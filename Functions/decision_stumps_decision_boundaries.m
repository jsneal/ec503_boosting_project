% This script is designed to find the best decision stump for each dataset
% and use that as the classifer for each dataset.

% This will calculate test and train ccr for each simulated dataset using a
% decision stump.

%% Decision Stump Separable Dataset
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\data_linear.mat');
load(data_dir); data_linear = dataset'; clear dataset;
% figure(1); gscatter(data_linear(:,1),data_linear(:,2),data_linear(:,3),'rb','+o');

%% Circular Dataset
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\circular_dataset.mat');
load(data_dir);
% figure(2); gscatter(data_circular(:,1),data_circular(:,2),data_circular(:,3),'rb','+o');

%% Linearaly Separable Not By Stump Dataset
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\linearly_separable_not_by_stump.mat');
load(data_dir); data_tilted = data; clear data;
% figure(3); gscatter(data_tilted(:,1),data_tilted(:,2),data_tilted(:,3),'rb','+o');

% (Dataset, Train/Test)
ccrs = zeros(3, 2);

datasets = cell(3, 1);
datasets{1} = data_linear;
datasets{2} = data_circular;
datasets{3} = data_tilted;

dense_grids = cell(3, 1);
for grid_num = 1:2
    x1_min = min(datasets{grid_num}(:, 1));
    x1_max = max(datasets{grid_num}(:, 1));
    x2_min = min(datasets{grid_num}(:, 2));
    x2_max = max(datasets{grid_num}(:, 2));
    row_num = 1;
    for x1_coord = x1_min:.01:x1_max
        for x2_coord = x2_min:.01:x2_max
            dense_grids{grid_num}(row_num, :) = [x1_coord, x2_coord, 0];
            row_num = row_num+1;
        end       
    end
end

grid_num = 3;
x1_min = min(datasets{grid_num}(:, 1));
x1_max = max(datasets{grid_num}(:, 1));
x2_min = min(datasets{grid_num}(:, 2));
x2_max = max(datasets{grid_num}(:, 2));
row_num = 1;
for x1_coord = x1_min:1:x1_max
    for x2_coord = x2_min:1:x2_max
        dense_grids{grid_num}(row_num, :) = [x1_coord, x2_coord, 0];
        row_num = row_num+1;
    end       
end

predicted_labels_train = cell(3, 1);
predicted_labels_test = cell(3, 1);
%%
for i = 1:3
    data = datasets{i};
    n = size(data,1);

    train_end = n*.8;
    randOrder = randperm(n);
    data_train = data(randOrder(1:train_end),:);
%     data_test = data(randOrder(train_end+1:n),:);
%     data_test = 
    data_test = dense_grids{i};
    n_train = size(data_train, 1);
    n_test = size(data_test, 1);
    
    predicted_labels_train{i} = zeros(n_train, 2);
    predicted_labels_test{i} = zeros(n_test, 2);
    
    weights = 1/n_train*ones(n_train,1);
    all_gs = calculate_gs(data_train);
    [best_feature, best_treshold, best_smaller_is, min_error] = calculate_best_g(data_train, weights, all_gs);
    
    xlabel('x1')
    ylabel('x2')
    
    % Train CCR
    for j = 1:n_train
        predicted_labels_train{i}(j, 1) = decision_stump(data_train(j, :), best_feature, best_treshold, best_smaller_is);
        predicted_labels_train{i}(j, 2) = data_train(j, end);
    end
    
    for j = 1:n_test
        data_test(j, 3) = decision_stump(data_test(j, :), best_feature, best_treshold, best_smaller_is);
    end
    
    figure(i); gscatter(data_test(:,1),data_test(:,2),data_test(:,3),'rb');
    hold on
    figure(i); gscatter(data_train(:,1),data_train(:,2),data_train(:,3),'rb');

end

