function [updated_weights] = update_weights(X, weights, best_feature, best_treshold, best_smaller_is, error)
% Function that updates the weights of the samples every iteration

% Inputs
%       X: data(vector: n rows (samples) and d+1 columns (d features + labels))
%       weights: updated weight for each sample
%       best_feature: which feature the best decision stump considers (number from 1 to d)
%       best_treshold: cutoff of best decision stump (real number)
%       best_smaller_is: determines which class it is when the feature value is
%                        smaller than the treshold (-1 or 1)
%       min_error: best error (of the best classifier) (between 0 and 1)

% Output
%       updated_weights: new weights at the end of every iteration

alpha = 0.5*log((1-error)/error);
z = 2*sqrt(error*(1-error));
updated_weights = zeros(size(weights,1),1);

for i=1:size(X,1)
    pred = decision_stump(X(i,1:end-1), best_feature, best_treshold, best_smaller_is);
    if (pred ~= X(i,end))
        updated_weights(i,1) = weights(i,1)*exp(alpha)/z;
    else
        updated_weights(i,1) = weights(i,1)*exp(-alpha)/z;
    end
end

end

