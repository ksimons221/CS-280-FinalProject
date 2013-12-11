function [histo] = myHist2(im)

    im = reshape(im, 1, []);
    histo = zeros(1,256);

    for i = 1:256
        lower_bound = i-1;
        upper_bound = i;
        if (i ~= 256)
            histo(i) = length(find(im >= lower_bound & im < upper_bound)); 
        else
            histo(i) = length(find(im >= lower_bound));
        end
        
    end
    
    histo = histo/length(im);
    
end

