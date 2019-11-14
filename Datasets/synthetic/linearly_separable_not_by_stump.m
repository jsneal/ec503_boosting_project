% A script to generate a linearly separable dataset
% that is  not separable by a decision stump.

data = zeros(100, 3);


for i = 1:100
    data(i, 1) = randi(100);
    data(i, 2) = randi([data(i, 1), data(i, 1) + randi([10,100])]);
    data(i, 3) = 1;
end

for j = 1:100
    data(100+j, 2) = randi(100);
    data(100+j, 1) = randi([data(i, 1), data(i, 1) + randi([10,100])]);
    data(100+j, 3) = -1;
end

% figure(1)
% gscatter(data(:, 1), data(:, 2), data(:, 3), 'rb')

save("linearly_separable_not_by_stump.mat", "data");

