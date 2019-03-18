function [y_in, dy_in, mus] = InitialCond(Exo)
% Description: The following function returns the initial position and 
% velocity of the exoplanets and star contained in 'Exo', in a reference
% plane where the origin is the system's center of mass. 

% Input: 

% Output: 

Constants;                                  % Load constant values

ExoInitCond1 = zeros(length(Exo), 6);       % Initialize Exoplanet Initial conditions vector in reference 1
n = length(Exo);                            % Number of exoplanets (known and random)

SysMasses = [[Exo.pmass], Exo(1).smass];    % Create System masses vector
mus = SysMasses' * G;                       % Create mus vector

t = 0;                                      % Asign time of initial conditions to 0
for i = 1 : n                               % Iterate over all exoplanets
    mu = mus(i) + mus(end);                                                 % Calculate particular mu (exoplanet and star)
    ExoInitCond1(i, :) = OE2SV(Exo(i).a, Exo(i).e, Exo(i).I, Exo(i).om, ... % Compute exoplanet initial conditions
                         Exo(i).RAAN, Exo(i).M0, Exo(i).T, mu, t);
end

SysInitPos1 = [ExoInitCond1(:, 1 : 3); zeros(1, 3)];                        % Create System Inital position matrix in reference 1

TotalMass = sum(SysMasses);                                                 % Compute system's total mass             
for i = 1 : 3
    CMpos(i) = sum(SysInitPos1(:, i)' .* SysMasses) / TotalMass;            % Calculate position of center of mass
end

for i = 1 : 3                                                               % Calcualte star velocity
    StarVel(i) = -sum(ExoInitCond1(:, i + 3)' .* [Exo.pmass]) ...           % Assuming static center of mass
                                / (TotalMass);
end
CMvel = -StarVel;                                                           % Calculate center of mass velocity in reference 1
SysInitVel1 = [ExoInitCond1(:, 4 : 6); zeros(1, 3)];                        % Create system Inital velocity matrix in reference 1

SysInitPos2 = SysInitPos1 - CMpos;                                          % Change to reference 2
SysInitVel2 = SysInitVel1 - CMvel;                                          % Change to reference 2

y_in = zeros(3 * (n + 1), 1);
dy_in = zeros(3 * (n + 1), 1);
for i = 1 : (n + 1)
    y_in(3 * i - 2 : 3 * i, 1) = SysInitPos2(i, :)';
    dy_in(3 * i - 2 : 3 * i, 1) = SysInitVel2(i, :)';
end
end