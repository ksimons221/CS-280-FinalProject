function [ pyr ] = genPyrSameSize( img, type, level )

pyr = cell(1,level);
pyr{1} = im2double(img);
for p = 2:level
	pyr{p} =  impyramid(pyr{p-1}, 'reduce'); %pyr_reduce(pyr{p-1});
end

for p = level-1:-1:1 % adjust the image size
	osz = size(pyr{p+1})*2-1;
	pyr{p} = pyr{p}(1:osz(1),1:osz(2),:);
end

if strcmp(type,'gauss'), return; end



for p = 1:level-1
	pyr{p} = pyr{p}-  impyramid(pyr{p+1}, 'expand'); %  pyr_expand(pyr{p+1});
end


end

