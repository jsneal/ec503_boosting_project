function [alphas,classifiers] = AdaBoost(data_train, T, all_gs)
% Function that runs our own implementation of AdaBoost

% Inputs
%       data_train: trainin set of  a dataset(n rows (samples) and d+1 columns (d features + labels))
%       T: number of iterations of the algorithm
%       all_gs: all possible weak classifiers

% Output
%       alphas: weight of each weak classifier
%       classifiers: all of the best classifiers

n = size(data_train,1);

alphas = zeros(T,1);
classifiers = zeros(T,3);
weights = 1/n*ones(n,1);
for t=1:T
    [best_feature, best_treshold, best_smaller_is, min_error] = calculate_best_g(data_train, weights, all_gs);
    alphas(t,1) = 0.5*log((1-min_error)/min_error);
    classifiers(t,:) = [best_feature, best_treshold, best_smaller_is];
    weights = update_weights(data_train, weights, best_feature, best_treshold, best_smaller_is, min_error);
end

end

