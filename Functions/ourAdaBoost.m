%% AdaBoost John, Nadim, Karim

%% Linear dataset
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\data_linear.mat');
load(data_dir); data_linear = dataset'; clear dataset;
figure; gscatter(data_linear(:,1),data_linear(:,2),data_linear(:,3),'rb','+o');

%% Circular Dataset
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\circular_dataset.mat');
load(data_dir);
figure; gscatter(data_circular(:,1),data_circular(:,2),data_circular(:,3),'rb','+o');

%%
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\linearly_separable_not_by_stump.mat');
load(data_dir); data_tilted = data; clear data;
figure; gscatter(data_tilted(:,1),data_tilted(:,2),data_tilted(:,3),'rb','+o');

%% AdaBoost on Circular Dataset
n = size(data_circular,1);
Ts = [1,3,5,7,10,20,50,100,200];
all_gs = calculate_gs(data_circular);
CCRs = zeros(numel(Ts),1);

randOrder = randperm(n);
data_circular_train = data_circular(randOrder(1:160),:);
data_circular_test = data_circular(randOrder(161:200),:);
for i=1:numel(Ts)
    
    T = Ts(i);
    alphas = zeros(T,1);
    classifiers = zeros(T,3);
    weights = 1/n*ones(n,1);
    for t=1:T
        [best_feature, best_treshold, best_smaller_is, min_error] = calculate_best_g(data_circular_train, weights, all_gs);
        alphas(t,1) = 0.5*log((1-min_error)/min_error);
        classifiers(t,:) = [best_feature, best_treshold, best_smaller_is];
        weights = update_weights(data_circular_train, weights, best_feature, best_treshold, best_smaller_is, min_error);
    end
    CCRs(i,1) = test_our_boosted_classifier(data_circular_test,alphas,classifiers);

end
%% CCR
semilogx(Ts,CCRs,'*-'); xlabel('T'); ylabel('CCR'); title('CCRs for Circular Dataset');

%% AdaBoost on Tilted Dataset
n = size(data_tilted,1);
T = 200;
weights = 1/n*ones(n,1);
all_gs = calculate_gs(data_tilted);
alphas = zeros(T,1);
classifiers = zeros(T,3);

randOrder = randperm(n);
data_tilted_train = data_tilted(randOrder(1:160),:);
data_tilted_test = data_tilted(randOrder(161:200),:);

for t=1:T
    [best_feature, best_treshold, best_smaller_is, min_error] = calculate_best_g(data_tilted_train, weights, all_gs);
    alphas(t,1) = 0.5*log((1-min_error)/min_error);
    classifiers(t,:) = [best_feature, best_treshold, best_smaller_is];
    weights = update_weights(data_tilted_train, weights, best_feature, best_treshold, best_smaller_is, min_error);
end

CCR = test_our_boosted_classifier(data_tilted_test,alphas,classifiers);
