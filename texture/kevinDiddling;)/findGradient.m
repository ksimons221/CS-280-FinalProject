function [ angle, magnitude ] = findGradient( dx, dy )

height = size(dx,1);
width = size(dx,2);


angle = ones(height, width); 
magnitude = ones(height, width);

for i = 1:height
    for j = 1:width
        singleDX = dx(i,j);
        singleDY = dy(i,j);
        if singleDX == 0 && singleDY == 0
            angle(i,j) = 0;
        else
            angle(i,j) = atand(singleDY/ singleDX); %atan for radians. To get degrees use atand. straing atan2
        end
        magnitude(i,j) = sqrt( singleDX^2 + singleDY^2);
    end
end

%ROUNDING FOR DIRECTION
for i = 1:height
    for j = 1:width
        oldValue = angle(i,j);
        if oldValue < 22.5 && oldValue > -22.5
            oldVal = 0;
        elseif oldValue < 67.5 && oldValue > 22.5
            oldVal = 45;
        elseif (oldValue < 91 && oldValue > 67.5) ||  (oldValue > -91 && oldValue < -67.5)
            oldVal = 90;
        elseif oldValue > -67.5 && oldValue < -22.5
            oldVal = 135;
        end
        angle(i,j) = oldVal;
    end
end


end

