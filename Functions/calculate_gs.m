% calculate_gs.m
% Finds the decison threshold

function all_gs = calculate_gs(data)
    labels = data(:, 3);
    [feature_num, n] = size(data);
    feature_num = feature_num-1;
    all_gs = zeros(1, 3);
    possible_thresholds = [];
    smaller_is_vec = [];
    for feature_index = 1:feature_num
        feature_data_and_labels = [data(:, feature_index) labels];
        feature_data_and_labels = sort(feature_data_and_labels);
        for i = 2:n
            if feature_data_and_labels(i) ~= feature_data_and_labels(i-1)
                threshold = i;
                possible_thresholds = [possible_thresholds threshold];
                if label(i) == 1
                   smaller_is_vec = [smaller_is -1];
                else
                   smaller_is_vec = [smaller_is 1];
                end
            end
        end
        
        errors_for_thresholds = zeros(1, length(possible_thresholds));
        
        for Ti = 1:possible_thresholds
            if smaller_is(Ti) == -1
                predicted_labels = [-1.*ones(1, i-1) ones(1, n-i-1)];
            else
                predicted_labels = [ones(1, i-1) -1.*ones(1, n-i-1)];
            end
            
            errors_for_thresholds(Ti) = sum(predicted_labels' ~= labels)/n;
        end
        
        [minimum, argmin] = min(errors_for_thresholds);
        
    end

    all_gs(Ti, 1) = (feature_data_and_labels(argmin, 1) + feature_data(argmin + 1, 1))/2;
    all_gs(Ti, 2) = smaller_is_vec(Ti);
    all_gs(Ti, 3) = feature_index;
    
end