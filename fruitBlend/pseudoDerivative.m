function [ results ] = pseudoDerivative( values )

    results = zeros(1, size(values, 2) - 1);
    
    
    for i = 1:size(values, 2) - 1
        results(i) = values(i + 1) - values(i);
    end


end

