function create_confusion (test_set, alphas, classifiers)

% Creates a confusion matrix given a test dataset, alphas and classifiers

rows = size(test_set,1);
columns = size(test_set,2);
known = test_set(:,end);
predicted = zeros(rows,1);

for i=1:rows
    predicted(i,1) = decision (test_set(i,1:columns-1), alphas, classifiers);
end

confusionchart(known,predicted);

end




