function [ H4_filters ] = inH4(m)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

N= 49;
H4_filters = zeros(N,N,4);

H4_vert = ones(N, N);
center = (N+1)./2;
mesh_size = 0.1;
for x =1:N
    for y = 1:N
    H4_vert(x,y) = (2.858*mesh_size*(center -x) - 2.982*(mesh_size*(center -x))^3 + 0.3975*(mesh_size*(center-x))^5)*exp(-((mesh_size*(center-x))^2 + (mesh_size*(center-y))^2));
    %H4(x,y) = (-2.205*(x-center) + 0.978*(x-center)^3)*exp(0.007*(-(x-center)^2 - (y-center)^2));
    end
end

Norm = sum(sum(H4_vert));

 H4_vert = H4_vert./Norm;

%imagesc(H4_vert);

H4_horz = ones(N, N);
center = (N+1)./2;
mesh_size = 0.1;
for x =1:N
    for y = 1:N
    H4_horz(x,y) = (2.858*mesh_size*(center-y) - 2.982*(mesh_size*(center-y))^3 + 0.3975*(mesh_size*(center-y))^5)*exp(-((mesh_size*(center-x))^2 + (mesh_size*(center-y))^2));
    %H4(x,y) = (-2.205*(x-center) + 0.978*(x-center)^3)*exp(0.007*(-(x-center)^2 - (y-center)^2));
    end
end



Norm = sum(sum(H4_horz));

 H4_horz = H4_horz./Norm;

%imagesc(H4_horz);



H4_45 = ones(N, N);
center = (N+1)./2;
mesh_size = 0.1;
vect_a = [1, -1]./(sqrt(2));
vect_b = [1, 1]./(sqrt(2));
for x =1:N
    for y = 1:N
    dot_a= [mesh_size*(center-x), mesh_size*(center-y)]*vect_a';
    dot_b = [mesh_size*(center-x), mesh_size*(center-y)]*vect_b';
    H4_45(x,y) = (2.858*dot_a - 2.982*(dot_a)^3 + 0.3975*(dot_a)^5)*exp(-(((dot_a))^2 + ((dot_b))^2));
    end
end


 H4_45 = H4_45./Norm;






H4_135 = ones(N, N);
center = (N+1)./2;
mesh_size = 0.1;
vect_a = [1, -1]./(sqrt(2));
vect_b = [1, 1]./(sqrt(2));
for x =1:N
    for y = 1:N
    dot_a= [mesh_size*(center-x), mesh_size*(center-y)]*vect_a';
    dot_b = [mesh_size*(center-x), mesh_size*(center-y)]*vect_b';
    H4_135(x,y) = (2.858*dot_b - 2.982*(dot_b)^3 + 0.3975*(dot_b)^5)*exp(-(((dot_a))^2 + ((dot_b))^2));
    end
end


H4_135 = H4_135./Norm;


H4_filters(:,:,1) = H4_vert;
H4_filters(:,:,2) = H4_horz;
H4_filters(:,:,3) = H4_45;
H4_filters(:,:,4) = H4_135;


end

