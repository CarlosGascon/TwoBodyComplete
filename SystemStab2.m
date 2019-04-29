function [Stab, a, e, PerStab] = SystemStab2(Target, m)
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

amin = 0.05;
amax = 50;
mmin = 0.00071617;
mmax = 134.454;

a = logspace(log10(amin), log10(amax), N1);
e = 0.1;
m = logspace(log10(mmin), log10(mmax), N2);

parpool(Ncores);
parfor (i = 1 : N1, Ncores)
    Stabcase = zeros(1, length(m));
    for j = 1 : length(m)
        
        Stabcase(j) = Integration(Target, a(i), e, m(j));
      
    end
    Stab(i, :) = Stabcase;
    
end

ImagPoints = nnz(Stab >= 0);
StabPoints = nnz(Stab == 7);

PerStab = StabPoints / ImagPoints;

end

