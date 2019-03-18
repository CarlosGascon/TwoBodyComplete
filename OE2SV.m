function [SV] = OE2SV(a, e, I, om, RAAN, M0, T, mu, t)
% Description: The following function returns the state vector of a body
% given its orbital parameters and a time t. 

% Input: 
    % - All: Function inputs are semimajor axis(a), eccentricity(e), 
    % inclination(I), longitude of periastron(om), right ascension of 
    % ascending node(RAAN), mean anomaly (M0) at a time T, gravitational 
    % parameter mu and time t. 

% Output:
    % - SV: Row state vector containing the position (SV(1 : 3)) and
    % velocity (SV(4 : 6)) at the time t. 


n = sqrt(mu / (a ^ 3));                                 % Calculate Mean motion
M = M0 + n * (t - T);                                   % Calculate Mean anomaly for t

%E = M+(e-0.125*(e^3))*sin(M)+0.5*(e^2)*sin(2*M)+0.375*(e^3)*sin(3*M);
E = SolveKepler(M, e);                                     % Solve Kepler Equation with Newton-Raphson

nu = 2 * atan(sqrt((1 + e) / (1 - e)) * tan(E / 2));    % Calculate true anomaly from eccentric anomaly

p = a * (1 - e ^ 2);                                    % Calculate semilatus rectum
r = p / (1 + e * cos(nu));                              % Compute distance
r_vec = r * [cos(nu); sin(nu); 0];                      % Position in auxiliar reference
v_vec = sqrt(mu / p) * [- sin(nu); e + cos(nu); 0];     % Velocity in auxiliar reference

Rz = @(ang) ([cos(ang),  sin(ang), 0;...                % Rotation matrix about the z-axis
              -sin(ang), cos(ang), 0;...
              0,         0,        1]);
          
Rx = @(ang) ([1,        0,         0;...                % Rotation matrix about the x-axis
              0, cos(ang),  sin(ang);...
              0, -sin(ang), cos(ang)]);
          
Rot = Rz(- RAAN) *  Rx(- I) * Rz(- om);                 % Total rotation matrix
r_vec = double(Rot * r_vec);                            % Convert position to desired reference
v_vec = double(Rot * v_vec);                            % Convert velocity to desired reference
SV = [r_vec', v_vec'];                                  % Create output vector
end

