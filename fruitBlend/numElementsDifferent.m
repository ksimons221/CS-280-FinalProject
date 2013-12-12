function [ numDifferent ] = numElementsDifferent( m1, m2 )

[h, w ] = size(m1);
numDifferent = 0;


for i = 1: h
    for j = 1: w
        if m1(i,j) ~= m2(i,j)
            numDifferent = numDifferent + 1;
        end
    end
end

end

