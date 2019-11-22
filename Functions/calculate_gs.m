% calculate_gs.m
% Finds the descison threshold

function all_gs = calculate_gs(data)
    labels = data(:, 3);
    [n, feature_num] = size(data);
    feature_num = feature_num-1;
    all_gs = zeros(1, 3);
    row = 1;
    for feature_index = 1:feature_num
        feature_data_and_labels = [data(:, feature_index) labels];
        feature_data_and_labels = sort(feature_data_and_labels);
        all_gs(row, 1) = feature_data_and_labels(1, 2) - 1;
        
        if feature_data_and_labels(1, 2) == 1
           all_gs(row, 2) = -1;
        else
           all_gs(row, 2) = 1;
        end
        all_gs(row, 3) = feature_index; 
        row = row+1; 
        
        all_gs(row, 1) = feature_data_and_labels(end, 2) + 1;
        if feature_data_and_labels(end, 2) == 1
           all_gs(row, 2) = -1;
        else
           all_gs(row, 2) = 1;
        end
        all_gs(row, 3) = feature_index;
        row = row+1; 
        
        for i = 2:n
            if feature_data_and_labels(i, 2) ~= feature_data_and_labels(i-1, 2)
                all_gs(row, 1) = (feature_data_and_labels(i, 1) + feature_data_and_labels(i + 1, 1))/2;
                if feature_data_and_labels(i, 2) == 1
                   all_gs(row, 2) = -1;
                else
                   all_gs(row, 2) = 1;
                end
                all_gs(row, 3) = feature_index; 
                row = row+1;
            end
        end
        
    end
    
end