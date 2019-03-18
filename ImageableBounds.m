function [a1, a2] = ImageableBounds(e, m, d)
% Description: The following function calculates the semimajor axis
% imageable bounds of a planet with a given mass and eccentricy, at a
% particular distance from earth. 

% Input:  - e: Planet's eccentricity
%         - m: Planet's mass (Jupiter Masses)
%         - d: Planet's distance from earth (AU)
% Output: - a1 and a2: Semimajor axis bounds (AU)

Constants;                 % Load constant values
a1 = (IWA * d) / (1 + e);       % Obtain inferior bound

Rp = RfromM(m);                 % Estimate Planet radius from mass

a2 = sqrt((p * (Rp ^ 2)) / (2 * dmag * ((1 - e) ^ 2)));  % Obtain superior bound

end

