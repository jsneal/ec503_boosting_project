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
t= 100;
i=2;

[alphas,classifiers]= AdaBoost(data_train,t, all_gs);
test_CCRs(i,1) = test_our_boosted_classifier(data_test,alphas,classifiers);
train_CCRs(i,1) = test_our_boosted_classifier(data_train,alphas,classifiers);

% 
% if (i==9)
%     create_confusion(data_tilted_test,alphas,classifiers);
% end
