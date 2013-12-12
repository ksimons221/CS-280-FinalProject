function [ sumsOfCDF ] = plotAllCdfs( newTexture, im )

[w, h] = size(newTexture);

half = floor(w/2);
clf;
[newCdf] = makeCDFTtemp(uint8(newTexture));
[oldCdf] = makeCDFTtemp(uint8(im));
[leftCdf] = makeCDFTtemp(uint8(newTexture(:,1:half)));
[rightCdf] = makeCDFTtemp(uint8(newTexture(:,half:end)));

plot(newCdf);
hold on;
plot(oldCdf, 'r');
plot(leftCdf, 'g');
plot(rightCdf, 'c');


xlabel('Pixel Intensity');
ylabel('Percentage');
legend('New Cdf', 'Old Cdf', 'Left Cdf', 'Right Cdf');

sumsOfCDF = [sum(newCdf), sum(oldCdf), sum(leftCdf), sum(rightCdf)]

end

