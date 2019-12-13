% Sonar Kernel SVM

%% load data

clear; clc;

main_dir = dir('..');
main_dir = main_dir.folder;
data_dir = strcat(main_dir,  '\Datasets\small_scale\sonar_csv.xls');
data = readmatrix(data_dir);

n = size(data,1);
randOrder = randperm(n);
data_train = data(randOrder(1:143),:);
data_test = data(randOrder(144:208),:);

x_train = data_train(:, 1:end-1);
y_train = data_train(:, end);
y_train = [y_train zeros(length(y_train), 1)];

x_test = data_test(:, 1:end-1);
y_test = data_test(:, end);
y_test = [y_test zeros(length(y_test), 1)];

SVMModel = fitcsvm(x_train,y_train(:, 1),'KernelFunction','Quad',...
    'Standardize',false,'ClassNames',[-1,1]);

[label,score] = predict(SVMModel,x_train);
y_train(:, 2) = label;


[label,score] = predict(SVMModel,x_test);
y_test(:, 2) = label;  

train_ccr = sum(y_train(:, 1) == y_train(:, 2))/size(y_train, 1);
test_ccr = sum(y_test(:, 1) == y_test(:, 2))/size(y_test, 1); 

