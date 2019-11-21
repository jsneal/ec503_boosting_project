function error = find_error(X, weights, feature, treshold, smaller_is)
% Function that finds the error for a chosen decision stump

% Inputs
%       X: data(vector: n rows (samples) and d+1 columns (d features + labels))
%       weights: updated weight for each sample
%       feature: which feature the decision stump considers (number from 1 to d)
%       treshold: cutoff of decision stump (real number)
%       smaller_is: determines which class it is when the feature value is
%                   smaller than the treshold (-1 or 1)

% Output
%       error: error for that decision stump (between 0 and 1)

error = 0;
for i=1:size(X,1)
    pred = decision_stump(X(i,1:2), feature, treshold, smaller_is);
    if (pred ~= X(i,3))
        error = error + weights(i);
    end
end

end