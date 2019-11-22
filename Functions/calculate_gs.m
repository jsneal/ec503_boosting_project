function all_gs = calculate_gs(data)
% Function that returns all possible decision stumps given the data
% Inputs
%       data: n x d+1 matrix where:
%                                   - row i are the feature values plus
%                                     label value.
%                                   - column j for 1 < j < d are feature
%                                     values for all examples
%                                     column d+1 is the column of labels
%                                     for each examples
%                                   

% Output
%       all_gs:  each row has [feature_num threshold smaller_is]
%                # of rows = number of possible decision stumps.
    labels = data(:, 3);
    [n, feature_num] = size(data);
    feature_num = feature_num-1;
    all_gs = zeros(1, 3);
    row = 1;
    for feature_index = 1:feature_num
        feature_data_and_labels = [data(:, feature_index) labels];
        feature_data_and_labels = sortrows(feature_data_and_labels, 1);
        all_gs(row, 2) = feature_data_and_labels(1, 1) - 1;
        
        if feature_data_and_labels(1, 2) == 1
           all_gs(row, 3) = -1;
        else
           all_gs(row, 3) = 1;
        end
        all_gs(row, 1) = feature_index; 
        row = row+1; 
        
        all_gs(row, 2) = feature_data_and_labels(end, 1) + 1;
        if feature_data_and_labels(end, 2) == 1
           all_gs(row, 3) = -1;
        else
           all_gs(row, 3) = 1;
        end
        all_gs(row, 1) = feature_index;
        row = row+1; 
        
        for i = 2:n
            if feature_data_and_labels(i, 2) ~= feature_data_and_labels(i-1, 2)
                all_gs(row, 2) = (feature_data_and_labels(i, 1) + feature_data_and_labels(i + 1, 1))/2;
                if feature_data_and_labels(i, 2) == 1
                   all_gs(row, 3) = -1;
                else
                   all_gs(row, 3) = 1;
                end
                all_gs(row, 1) = feature_index; 
                row = row+1;
            end
        end
        
    end
    
end