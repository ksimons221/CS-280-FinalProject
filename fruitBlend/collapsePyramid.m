function [ img ] = collapsePyramid( pyr )

for p = length(pyr)-1:-1:1
	pyr{p} = pyr{p}+   impyramid(pyr{p+1}, 'expand'); %pyr_expand(pyr{p+1});
end
img = pyr{1};

end

