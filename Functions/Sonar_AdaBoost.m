%% AdaBoost used on a small scale binary dataset (labels: +1 rock, -1 mine)

clear; clc;

main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\small_scale\sonar_csv.xls');
data = readmatrix(data_dir);

%%
n = size(data,1);
Ts = [1,3,5,7,10,20,50,100,300];
test_CCRs = zeros(numel(Ts),1);
train_CCRs = zeros(numel(Ts),1);

randOrder = randperm(n);
data_train = data(randOrder(1:143),:);
data_test = data(randOrder(144:208),:);
all_gs = calculate_gs(data);
for t = 1:numel(Ts)
    [alphas,classifiers]= AdaBoost(data_train,Ts(t), all_gs);
    test_CCRs(t,1) = test_our_boosted_classifier(data_test,alphas,classifiers);
    train_CCRs(t,1) = test_our_boosted_classifier(data_train,alphas,classifiers);
end

%%
figure(1)
semilogx(Ts,train_CCRs,'*-'); xlabel('T'); ylabel('CCR'); title('Train/Test CCR on Sonar (Our AdaBoost)');
hold on;
semilogx(Ts,test_CCRs,'*-');
legend('Train CCRs', 'Test CCRs','Location','east');


figure(2)
create_confusion(data_test,alphas,classifiers);
%%
n = size(data,1);
randOrder = randperm(n);
data_train = data(randOrder(1:143),:);
data_test = data(randOrder(144:208),:);

n_train = size(data_train, 1);
n_test = size(data_test, 1);

all_gs = calculate_gs(data);
    
predicted_labels_train = zeros(n_train, 2);
predicted_labels_test = zeros(n_test, 2);

weights = 1/n_train*ones(n_train,1);
all_gs = calculate_gs(data_train);
[best_feature, best_treshold, best_smaller_is, min_error] = calculate_best_g(data_train, weights, all_gs);

% Train CCR
for j = 1:n_train
    predicted_labels_train(j, 1) = decision_stump(data_train(j, :), best_feature, best_treshold, best_smaller_is);
    predicted_labels_train(j, 2) = data_train(j, end);
end
% Test CCR
for j = 1:n_test
    predicted_labels_test(j, 1) = decision_stump(data_test(j, :), best_feature, best_treshold, best_smaller_is);
    predicted_labels_test(j, 2) = data_test(j, end);
end
   


stump_ccrs(1) = sum(predicted_labels_train(:, 1) == predicted_labels_train(:, 2))/size(predicted_labels_train, 1);
stump_ccrs(2) = sum(predicted_labels_test(:, 1) == predicted_labels_test(:, 2))/size(predicted_labels_test, 1); 


figure(3)
bar(stump_ccrs)
xticklabels({'Train', 'Test'})
title('Train/Test CCR For Best Decision Stump on Sonar Dataset')
xlabel('Train/Test Dataset')
ylabel('CCR')


