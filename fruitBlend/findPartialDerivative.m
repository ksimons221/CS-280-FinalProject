function [ dx, dy ] = findPartialDerivative(im)

dxKernel = [-1, 0 1; -2, 0 2; -1, 0 1];
dyKernel = [-1, 0 1; -3, 0 3; -1, 0 1];

%dyKernel = [1, 1, 1; 0,0,0; -1, -1, -1];

dx = conv2(double(im),double(dxKernel), 'same');

dy = conv2(double(im),double(dyKernel), 'same');

end

