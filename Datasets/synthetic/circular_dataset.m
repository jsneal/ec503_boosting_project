%% Circular Synthetic datasets
clear;clc;

%% Circular Dataset
n = 200;
numPts = 0;
X = zeros(n,2);
Y = [-ones(n/2,1);ones(n/2,1)];

while(numPts<100)
    curX1 = 2*rand-1;
    curX2 = 2*rand-1;
    if (curX1^2 + curX2^2 < 1)
        X(numPts+1,1) = curX1;
        X(numPts+1,2) = curX2;
        numPts = numPts + 1;
    end
end

while(numPts<200)
    curX1 = 12.5*rand-6.25;
    curX2 = 12.5*rand-6.25;
    if (curX1^2 + curX2^2 >= 2.25 && curX1^2 + curX2^2 <= 6.25)
        X(numPts+1,1) = curX1;
        X(numPts+1,2) = curX2;
        numPts = numPts + 1;
    end
end

%% Plot
figure(1);
hold on;
gscatter(X(:,1),X(:,2),Y,'rb','o+');
plot(cos(0:pi/50:2*pi), sin(0:pi/50:2*pi),'k');
plot(1.5*cos(0:pi/50:2*pi), 1.5*sin(0:pi/50:2*pi),'k');
plot(2.5*cos(0:pi/50:2*pi), 2.5*sin(0:pi/50:2*pi),'k');
hold off;

%%
data_circular = [X,Y];
save("circular_dataset", "data_circular");
