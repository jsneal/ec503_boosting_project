%% Built-in AdaBoost used on a small scale binary dataset (labels: +1 rock, -1 mine)
clear; clc;

main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\small_scale\dataset_40_sonar.csv');

[data, txt, raw] = xlsread(data_dir);

labels_array = txt(2:end, 61);
labels = zeros(numel(labels_array), 1);

for i = 1:numel(labels_array)
    if (labels_array{i} == 'Rock')
        labels(i) = 1;
    else
        labels(i) = -1;
    end
end

data(:, end+1) = labels;
data(:, end+1) = zeros(numel(labels_array), 1);
%%
n = size(data,1);
Ts = [1,3,5,7,10,20,50,100,300];
test_CCRs = zeros(numel(Ts),1);
train_CCRs = zeros(numel(Ts),1);

randOrder = randperm(n);

Ts = [1,3,5,7,10,20,50,100,200,500,1000];
n_Ts = numel(Ts);
for j = 1:n_Ts
   randOrder = randperm(n);
   train_end = round(.7*n);
   data_train = data(randOrder(1:train_end),:);
   data_test = data(randOrder(train_end+1:n),:);
   n_train = size(data_train, 1);
   t = templateTree('MaxNumSplits', 1);
   ens = fitcensemble(data_train(:, 1:end-2), data_train(:, end-1), 'Method', 'AdaBoostM1', ...
   'NumLearningCycles',Ts(j),'Learners',t);
   data_test(:, end) = predict(ens,data_test(:, 1:end-2));
   data_train(:, end) = predict(ens,data_train(:, 1:end-2));
   n_test = size(data_test, 1);
   train_CCRs(j) = sum(data_train(:, end-1) == data_train(:, end))/n_train;
   test_CCRs(j) = sum(data_test(:, end-1) == data_test(:, end))/n_test;
   fprintf('%d\n', Ts(j));
end

figure(1)
semilogx(Ts,train_CCRs(:),'*-')
hold on
semilogx(Ts,test_CCRs(:),'*-')
title_str = ' Train/Test CCR';
title(title_str)
xlabel('T')
ylabel('CCR')
legend('Train', 'Test')

% t= 100;
% i=2;
% 
%     [alphas,classifiers]= AdaBoost(data_train,t, all_gs);
%     test_CCRs(i,1) = test_our_boosted_classifier(data_test,alphas,classifiers);
%     train_CCRs(i,1) = test_our_boosted_classifier(data_train,alphas,classifiers);
% 
% if (i==9)
%     create_confusion(data_tilted_test,alphas,classifiers);
% end
