function [maxbet, Stab] = SystemHill(a, e, I, m)
% Description: The following function computes de maximum AMD stability
% parameter of a system.

% Input: 
    % - m: Array containing the system's masses
    % - a: Array containing the system's semimajor axes
    % - e: Array containing the system's eccentricities
    % - i: Array containing the system's inclinations

% Output: 
    % - maxbet: maximum AMD stability parameter
    % - bet: Array containing all AMD stability parameters

n = length(m);                        % Number of bodies in the system
maxbet = -Inf;                        % Initialize maximum AMD stability parameter
bet = zeros(1, n - 2);                % Initialize array of AMD stability parameters

for i = 3 : n                         % Iterate over each planet
    
    gam = m(i - 1) / m(i);            % Calculate mass ratio
    alf = a(i - 1) / a(i);            % Calculate semimajor axis ratio
    e1 = e(i - 1);                    % Inner eccentricity
    e2 = e(i);                        % Outer eccentricity
    i1 = I(i - 1);                    % Inner inclination   
    i2 = I(i);                        % Outer inclination
    eps = (m(i - 1) + m(i)) / m(1);
    [bet(i), ~] = Hillstability(gam, alf, eps, e1, e2, i1, i2);   % Compute AMD stability paramater for pair of planets
    if maxbet < bet(i)                                      % Compare current beta with maximum
        maxbet = bet(i);                                    % Update maximum if necessary
    end
    
end
    if maxbet > 0
       Stab = 0; 
    else
       Stab = 1;
    end

end
