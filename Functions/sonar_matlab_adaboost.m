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
n_train = size(data_train, 1);
n_test = size(data_test, 1);
data_train(:, end+1) = zeros(n_train, 1);
data_test(:, end+1) = zeros(n_test, 1);
all_gs = calculate_gs(data);
for t = 1:numel(Ts)
    disp(t)
    tree = templateTree('MaxNumSplits', 1);
    ens = fitcensemble(data_train(:, 1:end-2), data_train(:, end-1), 'Method', 'AdaBoostM1', ...
           'NumLearningCycles',Ts(t),'Learners',tree);
    data_test(:, end) = predict(ens,data_test(:, 1:end-2));
    data_train(:, end) = predict(ens,data_train(:, 1:end-2));
    train_CCRs(t) = sum(data_train(:, end-1) == data_train(:, end))/n_train;
    test_CCRs(t) = sum(data_test(:, end-1) == data_test(:, end))/n_test;
end

%%
figure(1)
semilogx(Ts,train_CCRs,'*-'); xlabel('T'); ylabel('CCR'); title('Train/Test CCR on Sonar (MATLAB AdaBoost)');
hold on;
semilogx(Ts,test_CCRs,'*-');
legend('Train CCRs', 'Test CCRs','Location','east');

% tree = templateTree('MaxNumSplits', 1);
% ens = fitcensemble(data_train(:, 1:end-2), data_train(:, end-1), 'Method', 'AdaBoostM1', ...
%        'NumLearningCycles',20,'Learners',tree);
% data_test(:, end) = predict(ens,data_test(:, 1:60));
% data_train(:, end) = predict(ens,data_train(:, 1:60));

