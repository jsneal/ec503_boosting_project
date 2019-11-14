n = 10;
t = 5;

X = zeros (2,n);
y = zeros (1,n);

y(1:n/2) = -1;
y((n/2)+1:n) = 1;

X(1,1:n/2) = rand(1,n/2)*t;
X(1,(n/2)+1:n) = (rand(1,n/2)*t + t);

X(2,1:n/2) = rand(1,n/2)*t;
X(2,(n/2)+1:n) = rand(1,n/2)*t ;

gscatter(X(1,:),X(2,:),y,'mc')



