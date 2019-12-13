% Exploration of whether AdaBoost's CCR is affected by adding dimensions to
% circular dataset
clear; clc;


for dim = 2:10
    %% Circular Dataset
    disp(dim)
    main_dir = dir('..');
    main_dir = main_dir.folder;
    title_str = "\Datasets\synthetic\d_" + string(dim) + "_circular_dataset.mat";
    data_dir = strcat(main_dir,  title_str);
    load(data_dir);
    data_circular = kd_data_circular;

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
    
    figure(dim-1);
    title_str = "CCRs for Circular Dataset " + "(d = " + string(dim) + ")";
    semilogx(Ts,train_CCRs,'*-'); xlabel('T'); ylabel('CCR'); title(title_str);
    hold on;
    semilogx(Ts,test_CCRs,'*-');
    legend('Train CCRs', 'Test CCRs','Location','east');

end