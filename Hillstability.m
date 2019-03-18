function [bet, Stab] = Hillstability(gam, alf, eps, e1, e2, i1, i2)
% Description: The following function calculates the Hill stability of a
% given pair of planets using the AMD Hill criteria. 

% Input:  - All:  Input consits on the planets mass ratio gam (m1 / m2), semimajor
%                 axis ratio alf (a1 / a2), and the planets-star mass ratios
%                 eps (m1 + m2 / mstar). Also must include the
%                 eccentricities and inclinations of the given planets (e1, e2, i1, i2)

% Output: - bet: Ratio between the relative and critical AMD difference,
%                and the absolute value of the critical AMD
%         - Stab: Boolean indicating if the system is stable (1) or
%                unstable (0)

relAMD = @(e, ep, I, Ip) gam * sqrt(alf) * (1 - sqrt(1 - e ^ 2) * cos(I)) ...   % Define relative AMD function
             + (1 - sqrt(1 - ep ^ 2) * cos(Ip));
         
Cc = gam * sqrt(alf) + 1 - ((1 + gam) ^ (3 / 2)) * ...                          % Calculate the critical AMD    
     sqrt((alf / (gam + alf)) * (1 + (3^(4 / 3) * eps^(2 / 3) * gam) ...
     / (1 + gam)^2));

bet = (relAMD(e1, e2, i1, i2) - Cc) / abs(Cc);                                  % Compute the beta value described in the output

if bet > 0         % Check if system is unstable
    Stab = 0;      % Set Stab to zero 
else
    Stab = 1;      % Set Stab to one
end


end

