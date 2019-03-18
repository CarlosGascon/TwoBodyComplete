function [RandomExo] = GenerateExo(KnownExo, a, e, m)
% Description: The following function Generates a random exoplanet in the
% imageable region defined by the geometric and contrast limtiations. The
% random exoplanet structure contains the same fields as the knowns
% exoplanets. 

% Input:
    % - KnownExo: Array containing the structs for the known exoplanets in
    % the system analyzed. 

% Output: 
    % - RandomExo: Struct containing the information of the random
    % exoplanet generated

Constants;                                  % Load constant values 
RandomExo.system = KnownExo(1).system;      % Asign system nam
RandomExo.smass = KnownExo(1).smass;        % Asign system mass
RandomExo.plet = 'rand';                    % Asign planet letter 'rand' for random

RandomExo.I = acos((2 * rand - 1) * 0);           % Generate inclination

RandomExo.e = e;                % Generate eccentricity

RandomExo.om = 2 * pi * rand;               % Generate Longitude of periastron
RandomExo.dist = KnownExo(1).dist;          % Asign star distance
RandomExo.pmass = m;    %IMPORTANT: LOOK

RandomExo.RAAN = 2 * pi * rand ;             % Generate Longitude of ascending node
RandomExo.M0 = 2 * pi * rand ;               % Set mean anomaly to 0
RandomExo.T = 0;     

RandomExo.a = a;
RandomExo.per = 2 * pi * sqrt((RandomExo.a ^ 3) ...             
                / (G * (RandomExo.smass + RandomExo.pmass))) ;  % Calculate Orbital Period
                       
end

