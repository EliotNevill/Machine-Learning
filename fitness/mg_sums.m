function result = mg_sums(n_numbers, sums_to)
    if(n_numbers<=1)
        result = sums_to;
    else
        X = zeros(0, n_numbers);    
        for i = sums_to:-1:0
            rc = mg_sums(n_numbers - 1, sums_to - i);
            [M, ~] = size(rc);
            X = [X; i * ones(M, 1), rc];
        end    
        result = X;
    end
end