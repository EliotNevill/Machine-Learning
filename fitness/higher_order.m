function newX = higher_order( X, max_order )
    [~, n_vars] = size(X);
    stacked = zeros(0, n_vars);                     % this will collect all the coefficients...    
    for o = 1:max_order                             % for degree 1 polynomial to degree 'order'
      stacked = [stacked; mg_sums(n_vars, o)];
    end

    log_newX = log(X) * stacked';                   % this is the sexy step!
                                                    % multiplying log of data matrix by the    
                                                    % matrix of all possible exponent combinations
                                                    % effectively raises terms to powers and multiplies them!

    newX = exp(log_newX);                           % back to normal
end