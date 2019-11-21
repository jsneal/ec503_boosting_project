function [best_feature, best_treshold, best_smaller_is, min_error] = calculate_best_g(X, weights, all_gs)
% Function that returns the best classifier for the current iteration & set
% of weights

% Inputs
%       X: data(vector: n rows (samples) and d+1 columns (d features + labels))
%       weights: updated weight for each sample
%       all_gs: all possible classifiers (Column 1: feature, Column 2: treshold, Column 3: smaller_is)

% Output
%       best_feature: which feature the decision stump considers (number from 1 to d)
%       best_treshold: cutoff of decision stump (real number)
%       best_smaller_is: determines which class it is when the feature value is
%                   smaller than the treshold (-1 or 1)
%       min_error: best error (of the best classifier) (between 0 and 1)

min_error = inf;
for i=1:size(all_gs,1)
    
    temp_error = 0;
    for j=1:size(X,1)
        pred = decision_stump(X(j,1:2), all_gs(i,1), all_gs(i,2), all_gs(i,3));
        if (pred ~= X(j,3))
            temp_error = temp_error + weights(j);
        end
    end
    
    if (temp_error < min_error)
        min_error = temp_error;
        best_feature = all_gs(i,1);
        best_treshold = all_gs(i,2);
        best_smaller_is = all_gs(i,3);
    end
    
end

end

