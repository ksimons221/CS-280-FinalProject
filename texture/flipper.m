function [ flipped ] = flipper( in )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[w, h] = size(in);
flipped = zeros(w, h);

for x=1:w
    for y = 1:h
        flipped(x,y) = in(w - x + 1, h -y + 1); 
    end
end

end

