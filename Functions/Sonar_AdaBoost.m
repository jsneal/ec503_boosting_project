%% AdaBoost used on a small scale binary dataset (labels: +1 rock, -1 mine)
%% Outputs CCRs and confusion matrix for a given t

data = readmatrix('sonar_csv.xls');

n = size(data,1);
Ts = [1,3,5,7,10,20,50,100,300];
test_CCR = 0;
train_CCR = 0;

randOrder = randperm(n);
data_train = data(randOrder(1:143),:);
data_test = data(randOrder(144:208),:);
all_gs = calculate_gs(data);
t= 100;

    [alphas,classifiers]= AdaBoost(data_train,t, all_gs);
    test_CCR = test_our_boosted_classifier(data_test,alphas,classifiers);
    train_CCR = test_our_boosted_classifier(data_train,alphas,classifiers);

create_confusion(data_tilted_test,alphas,classifiers);