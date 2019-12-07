%% AdaBoost John, Nadim, Karim

%% Linear dataset
load('data_linear.mat'); 
data_linear = dataset'; 
clear dataset;


%% Circular Dataset
load('circular_dataset.mat');

%% 
load('linearly_separable_not_by_stump.mat'); data_tilted = data; clear data;


%% AdaBoost on Circular Dataset
n = size(data_circular,1);
T = 50;
alphas = zeros(T,1);
classifiers = zeros(T,3);
CCR = zeros(1,8);
train_size = zeros(1,8);
randOrder = randperm(n);
data_circular_test = data_circular(randOrder(161:200),:);

for i=1:8
    randOrder = randperm(n);
    data_circular_train = data_circular(randOrder(1:20*i),:);
    n_train = size(data_circular,1);
    weights = 1/n_train*ones(n_train,1);
    train_size(1,i) = size(data_circular_train,1);
    all_gs = calculate_gs(data_circular_train);

for t=1:T
    [best_feature, best_treshold, best_smaller_is, min_error] = calculate_best_g(data_circular_train, weights, all_gs);
    alphas(t,1) = 0.5*log((1-min_error)/min_error);
    classifiers(t,:) = [best_feature, best_treshold, best_smaller_is];
    weights = update_weights(data_circular_train, weights, best_feature, best_treshold, best_smaller_is, min_error);
end

CCR(1,i) = test_our_boosted_classifier(data_circular_test,alphas,classifiers);
end
subplot(2,1,1);
plot(train_size,CCR);
ylabel('CCR');
xlabel('# of training data points');
title('CCR as a function of training dataset size (circular dataset)');


%% AdaBoost on Tilted Dataset
n = size(data_tilted,1);
T = 50;
alphas = zeros(T,1);
classifiers = zeros(T,3);
CCR = zeros(1,8);
train_size = zeros(1,8);
randOrder = randperm(n);
data_tilted_test = data_tilted(randOrder(161:200),:);

for i=1:8
    randOrder = randperm(n);
    data_tilted_train = data_tilted(randOrder(1:20*i),:);
    n_train = size(data_circular,1);
    weights = 1/n_train*ones(n_train,1);
    train_size(1,i) = size(data_tilted_train,1);
    all_gs = calculate_gs(data_tilted_train);

for t=1:T
    [best_feature, best_treshold, best_smaller_is, min_error] = calculate_best_g(data_tilted_train, weights, all_gs);
    alphas(t,1) = 0.5*log((1-min_error)/min_error);
    classifiers(t,:) = [best_feature, best_treshold, best_smaller_is];
    weights = update_weights(data_tilted_train, weights, best_feature, best_treshold, best_smaller_is, min_error);
end

CCR(1,i) = test_our_boosted_classifier(data_tilted_test,alphas,classifiers);
end
subplot(2,1,2);
plot(train_size,CCR);
ylabel('CCR');
xlabel('# of training data points');
title('CCR as a function training dataset size (tilted dataset');


