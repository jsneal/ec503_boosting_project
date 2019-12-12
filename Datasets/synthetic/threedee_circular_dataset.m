%% Circular Synthetic datasets
clear;clc;

%% Circular Dataset
n = 200;
numPts = 0;
X = zeros(n,3);
Y = [-ones(n/2,1);ones(n/2,1)];

while(numPts<100)
    curX1 = 2*rand-1;
    curX2 = 2*rand-1;
    curX3 = 2*rand-1;
    if (curX1^2 + curX2^2 < 1)
        X(numPts+1,1) = curX1;
        X(numPts+1,2) = curX2;
        X(numPts+1,3) = curX3;
        numPts = numPts + 1;
    end
end

while(numPts<200)
    curX1 = 12.5*rand-6.25;
    curX2 = 12.5*rand-6.25;
    curX3 = 12.5*rand-6.25;
    
    if (curX1^2 + curX2^2 + curX3^2 >= 2.25 && curX1^2 + curX2^2 + curX3^2 <= 6.25)
        X(numPts+1,1) = curX1;
        X(numPts+1,2) = curX2;
        X(numPts+1,3) = curX3;
        numPts = numPts + 1;
    end
end

%% Plot
for i=1:99
    scatter3(X(i,1),X(i,2),X(i,3),'r','o');
    hold on
end

for i=100:200 
    scatter3(X(i,1),X(i,2),X(i,3),'g','diamond','filled');
    hold on
end
hold off    


%%
sreedee_data_circular = [X,Y];
save("threedee_circular_dataset", "sreedee_data_circular");
