function CCR = test_our_boosted_classifier (test_set, alphas, classifiers)

%Computes CCR given test data set, coefficients and classifiers as inputs
%uses 'decision.m'
%test_set (n,d+1) d+1 -> class

rows = size(test_set,1);
columns = size(test_set,2);
CCR = 0;

for i=1:size(test_set,1)
    prediction = decision (test_set(i,1:columns-1), alphas, classifiers);
    if (prediction == test_set(i,columns))
        CCR = CCR + 1;
    end
end

CCR = CCR / rows;

end
        