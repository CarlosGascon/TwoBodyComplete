function [Stab, a, e, PerStab] = SystemStab(Target, m)
% Description: The following function evaluates the system's imageable and
% stable points in a semimajor axis - eccentricity axis. 

% Input:  - Target: Struct array containing the system's exoplanets
%           information
%         - m: Additional exoplanet's mass in Jupiter masses

% Output: - Stab: Matrix containing the stability time (in log10 years)     
%           for every grid point. -1 indicates a non-imageable
%           point, while 0 refers to a Hill unstable point.
%         - a and e: Semimajor axis and eccentricity vectors respectively
%         - PerStab: Percentage of stable orbits
Constants;

Stab = zeros(N1, N2);

e = linspace(0, 0.5, N2);
for i = 1 : N2
    [aminbounds(i), amaxbounds(i)] = ImageableBounds(e(i), m, Target(1).dist);
end

amin = min(aminbounds);
amax = max(amaxbounds);

a = linspace(amin, amax, N1);

parpool(Ncores);
parfor (i = 1 : N1, Ncores)
    Stabcase = zeros(1, length(e));
    for j = 1 : length(e)
        if a(i) > aminbounds(j) && a(i) < amaxbounds(j)
            
            Exoinfo = [0, Target().a, a(i); 
                       0, Target().e, e(j);
                       0, [Target().I] - pi / 2, 0;
                       Target(1).smass, Target().pmass, m];

            Exoinfo = sortrows(Exoinfo');
            [~, Stabcase(j)] = SystemHill(Exoinfo(:, 1), Exoinfo(:, 2), ... 
                                         Exoinfo(:, 3), Exoinfo(:, 4)); 
            if Stabcase(j) == 1
                Stabcase(j) = Integration(Target, a(i), e(j), m);
            end
        else
            Stabcase(j) = -1;
        end
    end
    Stab(i, :) = Stabcase;
    
end

ImagPoints = nnz(Stab >= 0);
StabPoints = nnz(Stab == 7);

PerStab = StabPoints / ImagPoints;

end

