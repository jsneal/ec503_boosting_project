%% AdaBoost (heatmap) John, Nadim, Karim
clear; clc;

%% Linear dataset
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

%% Tilted Dataset
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\linearly_separable_not_by_stump.mat');
load(data_dir); data_tilted = data; clear data;
% figure(3); gscatter(data_tilted(:,1),data_tilted(:,2),data_tilted(:,3),'rb','+o');


%% Dense Grid formation
datasets = cell(3, 1);
datasets{1} = data_linear;
datasets{2} = data_circular;
datasets{3} = data_tilted;

dataset_classifiers = cell(3, 1);

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

for dataset_num = 1:3 
       Ts = [1,3,5,7,10,20,50,100,200,500,1000];
       j = 9;
       n_Ts = numel(Ts);
%        for j = 1:n_Ts
           data = datasets{dataset_num};
           n = size(data, 1);
           randOrder = randperm(n);
           train_end = round(.8*n);
           data_train = datasets{dataset_num}(randOrder(1:train_end),:);
           data_test = datasets{dataset_num}(randOrder(train_end+1:n),:);
           all_gs = calculate_gs(data_train);
           [alphas,classifiers] = AdaBoost(data_train, Ts(j), all_gs);
           n = size(dense_grids{dataset_num}, 1);
           for i=1:n
                dense_grids{dataset_num}(i, 3) = decision_unsigned(dense_grids{dataset_num}(i, 1:2), alphas, classifiers);
           end
end

%% Heatmap


figure(1)
% sz = 25;
% min_3 = min(dense_grids{1}(:, 3));
% max_3 = max(dense_grids{1}(:, 3));
% c = linspace(min_3, max_3, 20);
% scatter(dense_grids{1}(:, 1), dense_grids{1}(:, 2), round(dense_grids{1}(:, 3)))
% colormap jet
% colorbar
surf(dense_grids{2}(:, 1), dense_grids{2}(:, 2), round(dense_grids{2}(:, 3)))

% 
% figure(2)
% gscatter(dense_grids{2}(:, 1:3))
% % colormap jet
% % colorbar
% 
% figure(3)
% gscatter(dense_grids{1}(:, 1:3))
% % colormap jet
% % colorbar

