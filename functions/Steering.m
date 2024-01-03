function [A] = Steering(pos, aoa)

% Generate steering vector
% input: 
%       pos: antenna position, [(x1,y1,z1); (x2,y2,z2); (x3,y3,z3);  ... ]
%       aoa: elevation and azimuth, [(phi1,theta1); (phi2,theta2); (phi3,theta3);  ... ]
% output: 
%       A: steering vector

X = pos(:,1);
Y = pos(:,2);
Z = pos(:,3);

%% method 1
phi = aoa(:,1);   % elevation
theta = aoa(:,2); % azimuth

Delay = (cosd(phi).*cosd(theta))*(X(1)-X)' + (cosd(phi).*sind(theta))*(Y(1)-Y)' + sind(phi)*(Z(1)-Z)'; 
A = exp(-1j*pi*Delay);

end

