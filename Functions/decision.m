function prediction = decision (xtest, alphas, classifiers)

%This function outputs the predicted class of a single test point
%xtest (1,d)
%alphas (T,1)
%classifiers (T,3) feature, threshold, smaller_is (-1 or 1)

linear_combo = 0;
for i=1:length(alphas)
    predic = decision_stump(xtest,classifiers(i,1),classifiers(i,2),classifiers(i,3));
    linear_combo = linear_combo + alphas(i) * predic;
end

if (linear_combo == 0)
    prediction = 1;
else
    prediction = sign (linear_combo);
end






