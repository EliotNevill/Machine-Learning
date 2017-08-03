%start_date_local,moving_time,total_elevation_gain,average_speed,average_heartrate,max_heartrate,time of day
data = dlmread('data2.csv',",");
X = data(:, [1, 2, 3, 5, 6, 7]);
X(:,1) = X(:,1)-42891;
y = data(:, 4);
m = length(y);
n = columns(X);

plot(X(:,1),y,'r+')
xlabel('Day'); ylabel('Average Speed');
hold off



n_obs  = m;  % number observations
n_vars = n;     % number of variables
max_degree  = 6;     % order of polynomial


stacked = zeros(0, n_vars); %this will collect all the coefficients...    
for(d = 1:max_degree)          % for degree 1 polynomial to degree 'order'
    stacked = [stacked; mg_sums(n_vars, d)];
end

newX = zeros(size(X,1), size(stacked,1));
for(i = 1:size(stacked,1))
    accumulator = ones(n_obs, 1);
    for(j = 1:n_vars)
        accumulator = accumulator .* X(:,j).^stacked(i,j);
    end
    newX(:,i) = accumulator;
end
stacked;
X = newX;



[X mu sigma] = featureNormalize(X);
X = [ones(m, 1) X];





% Choose some alpha value
alpha = 0.0001;
num_iters = 400;
theta = zeros(size(X, 2), 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');
hold off


test_vals = mean(X,1);
datemax = max(X(:,2));
datemin = min(X(:,2));
speeds = []
dates = datemin:0.05:datemax
for date = dates
	test_vals(2) = date;
	speed = 0;
	%Calculate values from model
	for(i = 1:size(stacked))
		feat_val = theta(i);
		for(j = 1:length(stacked(i,:)))
			feat_val = feat_val * (test_vals(j)^stacked(i,j));
		end		
		speed = speed + feat_val;
	end
	speeds = [speeds speed];
end






%average_speed vs date
figure;

plot( dates, speeds, '-b', 'LineWidth', 2);

xlabel('Date');
ylabel('Speed');
hold off

