%% AdaBoost John, Nadim, Karim
clear; clc;
%% Linear dataset
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\data_linear.mat');
load(data_dir); data_linear = dataset'; clear dataset;
figure(1); gscatter(data_linear(:,1),data_linear(:,2),data_linear(:,3),'rb','+o');

%% Circular Dataset
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\circular_dataset.mat');
load(data_dir);
figure(2); gscatter(data_circular(:,1),data_circular(:,2),data_circular(:,3),'rb','+o');

%% Tilted Dataset
main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\synthetic\linearly_separable_not_by_stump.mat');
load(data_dir); data_tilted = data; clear data;
figure(3); gscatter(data_tilted(:,1),data_tilted(:,2),data_tilted(:,3),'rb','+o');

%% AdaBoost on Circular Dataset
n = size(data_circular,1);
Ts = [1,3,5,7,10,20,50,100,200];
test_CCRs = zeros(numel(Ts),1);
train_CCRs = zeros(numel(Ts),1);

randOrder = randperm(n);
data_circular_train = data_circular(randOrder(1:160),:);
data_circular_test = data_circular(randOrder(161:200),:);
all_gs = calculate_gs(data_circular);

for i=1:numel(Ts)
    [alphas,classifiers] = AdaBoost(data_circular_train, Ts(i), all_gs);
    test_CCRs(i,1) = test_our_boosted_classifier(data_circular_test,alphas,classifiers);
    train_CCRs(i,1) = test_our_boosted_classifier(data_circular_train,alphas,classifiers);

end
%% CCR
figure(4);
semilogx(Ts,train_CCRs,'*-'); xlabel('T'); ylabel('CCR'); title('CCRs for Circular Dataset');
hold on;
semilogx(Ts,test_CCRs,'*-');
legend('Train CCRs', 'Test CCRs','Location','southeast');

%% AdaBoost on Tilted Dataset
n = size(data_tilted,1);
Ts = [1,3,5,7,10,20,50,100,200,500,1000];
test_CCRs = zeros(numel(Ts),1);
train_CCRs = zeros(numel(Ts),1);

randOrder = randperm(n);
data_tilted_train = data_tilted(randOrder(1:160),:);
data_tilted_test = data_tilted(randOrder(161:200),:);
all_gs = calculate_gs(data_tilted);

for i=1:numel(Ts)
    [alphas,classifiers] = AdaBoost(data_tilted_train, Ts(i), all_gs);
    test_CCRs(i,1) = test_our_boosted_classifier(data_tilted_test,alphas,classifiers);
    train_CCRs(i,1) = test_our_boosted_classifier(data_tilted_train,alphas,classifiers);
end
%% CCR
figure(5);
semilogx(Ts,train_CCRs,'*-'); xlabel('T'); ylabel('CCR'); title('Train CCRs for Tilted Dataset');
hold on;
semilogx(Ts,test_CCRs,'*-');
legend('Train CCRs', 'Test CCRs','Location','southeast');
