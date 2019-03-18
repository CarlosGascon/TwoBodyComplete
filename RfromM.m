function [Rp] = RfromM(m)
% Description: The following function estimates the planet radius given its
% mass, based on a modified Forecaster best fit. 

% Input:  - m: Planet mass (Jupiter Masses)

% Output: - Rp: Planet radius (AU)

Constants;                 % Load constant values
m = m * (Mjup / Mearth);        % Convert input mass from Jupiter masses to Earth masses

Cvec = [0.00346053, -0.06613329, 0.48091861, 1.04956612, -2.84926757]; % Modified fit C parameters
Svec = [0.279, 0.50376436, 0.22725968, 0, 0.881];                      % Modified fit S parameters
Tvec = [0, 2.04, 95.16, 317.828407, 26635.6853, Inf];                  % Modified fit T parameters

[N, ~] = histcounts(m, Tvec);   % Identify Mass interval                                
C = Cvec * N';                  % Obtain corresponding C value
S = Svec * N';                  % Obtain corresponding S value

Rp = (10 ^(C + log10(m) * S)) * (Rearth * m2AU);  % Obtain planet radius and convert to AU

end

