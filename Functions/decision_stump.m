function predicted_class = decision_stump(xtest, feature, treshold, smaller_is)
% Function that returns the predicted class of a test point

% Inputs
%       xtest: test point (vector with dimensions 1xd)
%       feature: which feature the decision stump considers (number from 1 to d)
%       treshold: cutoff of decision stump (real number)
%       smaller_is: determines which class it is when the feature value is
%                   smaller than the treshold (-1 or 1)

% Output
%       predicted_class: predicted class according to that decision stump (-1 or 1)

if (xtest(1,feature) < treshold)
    predicted_class = smaller_is;
else
    predicted_class = -smaller_is;
end

end