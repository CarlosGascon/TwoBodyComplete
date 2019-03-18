function [Stabtime] = Integration(Target, a, e, m)
% Description: The following function integrates the particular system of
% study for the number of cases given by Ncases. 

% Input:  - All: Contains the Target System of study and the semimajor axis
%               (a), eccentricity (e) and mass (m) of the new planet.  

% Output: - Stabtime: Stability times mean value in log10(Years)

Constants;                         % Load constant values 
Stabtimes = zeros(1, Ncases);      % Initialize array containing stability times

for i = 1 : Ncases                                         % Iterate over the number of cases
    [Stabtimes(i)] = SingleIntegration(Target, a, e, m);   % Calculate single case stability time
end

Stabtime = mean(Stabtimes);         % Calculate stability times mean value

end

