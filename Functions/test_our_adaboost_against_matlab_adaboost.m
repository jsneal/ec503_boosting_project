clear
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

datasets = cell(3, 1);
datasets{1} = data_linear;
datasets{2} = data_circular;
datasets{3} = data_tilted;

dataset_classifiers = cell(3, 1);



for dataset_num = 1:3
   for T = 1:200
       data = datasets{dataset_num};
       feature_col_num = size(data, 2) - 1;
    %    for feature_num = 1:feature_col_num
    %        feature_and_labels = [data(:, feature_num) data(:, end)];
    %        thresholds{dataset_num, feature_num} = 
    %    end
       n = size(data, 1);
       randOrder = randperm(n);
       train_end = round(.7*n);
       data_train = data_tilted(randOrder(1:train_end),:);
       data_test = data_tilted(randOrder(train_end+1:n),:);
       t = templateTree('Surrogate', 'on', 'MaxNumSplits',1);
       ens = fitcensemble(data_train(:, 1:end-1), data_train(:, end), 'Method', 'AdaBoostM1', ...
       'NumLearningCycles',1000,'Learners',t);
        data_test(:, 4) = predict(ens,data_test(:, 1:2));
        n_test = size(data_test, 1);
        ccrs(dataset_num, T) = sum(data_test(:, 3) == data_test(:, 4))/n_test;
   end
end

