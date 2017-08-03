function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

pos = [];
neg = [];
for i = 1:rows(y)
	if (y(i) == 1)
		pos = [pos;X(i,1) X(i,2)];
	else
		neg = [neg;X(i,1) X(i,2)];
	endif
endfor
plot(pos(:,1), pos(:,2),'k+');
plot(neg(:,1), neg(:,2),'ko');






% =========================================================================



hold off;

end
