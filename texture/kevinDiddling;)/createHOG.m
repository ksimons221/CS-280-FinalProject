function [ hog ] = createHOG( angles )

[h, w] = size(angles);


hog = zeros(1,4);


for i = 1:h
    for j = 1:w
        value = angles(i,j);
        if value == 0
            hog(1) = hog(1) + 1;
        elseif value == 45
            hog(2) = hog(2) + 1;
        elseif value == 90
            hog(3) = hog(3) + 1;
        elseif value == 135
            hog(4) = hog(4) + 1;
        else
            disp('ERROR');
        end
    end
end

end

