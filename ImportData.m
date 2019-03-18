function [Targets] = ImportData(TargetList)
% Description: The following function creates (if it doesn't exist) the
% file 'Exoplanets.mat' by calling the ImportPlanets script.
% Additionally, reads the input TargetList and stores the selected 
% exoplanets in the output struct 'Targets'.  

% Input:
    % - TargetList: Should be formed by m rows, where m is the number of
    % systems to be analyzed. The first column of each row should contain 
    % the system name, while the second column should specify which planets
    % of the system will be considered. 
% Output: 
    % - Targets: Cell Array formed by m cells, one for each system, 
    % cointaining the information from the exoplanets specified in TargetList.
    % A particular cell contains the structs of the system's exoplanets
    % determined in TargetList. Each struct contains the fields from the
    % 'Exoplanets.mat' file, except for the 'type' field, which is removed.
    % If orbit inclination is unknown, it is generated, and planet mass is
    % updated if necessary. 
    
if ~isfile('Exoplanets.mat')    % Check if the Exoplanets file exists
    ImportPlanets;              % Create Exoplanet file
end     

Constants; 
load('Exoplanets.mat')          % Load Exoplanets.mat
[m, ~] = size(TargetList);      % Read TargetList size


for i  = 1 : m                              % Iterate over every system in TargetList
    for j = 1 : length(TargetList{i, 2})    % Iterate over specified planets for every system
        pindex = find(strcmp({Exoplanets.system}, TargetList{i, 1}) == 1 ... % Search for system specified in TargetList 
                 & strcmp({Exoplanets.plet}, TargetList{i, 2}(j))==1);       % and planet with correspoding letter
        Exoplanet = Exoplanets(pindex);
        
        if(isnan(Exoplanet.I))                      % Check if inclination is unknown
           max = cos(asin((Exoplanet.pmass * Mjup) / (0.08 * Msun)));      % Maximum inclination value considering planet mass below 0.08 sun's Mass
           Exoplanet.I = acos((2 * rand - 1) * 0.08727 * 0) ;                       % Generate random inclination
           if(Exoplanet.type == 'Msini')                                   % Check if Exoplanet is 'Msini' type
              Exoplanet.pmass =  Exoplanet.pmass / sin(Exoplanet.I);       % Update planet mass
           end
        end
        if(isnan(Exoplanet.per))                                           % Check if orbital period is known
            Exoplanet.per = 2 * pi * sqrt((Exoplanet.a ^ 3) ... 
                            / (G * (Exoplanet.smass + Exoplanet.pmass))) ; % Calculate orbital period 
        end
        
        Exoplanet.RAAN = 2 * pi * rand;                         % Set Longitude of ascending node to 0
        Exoplanet.M0 = 2 * pi * rand;                           % Set Initial Mean Anomaly to 0
        Exoplanet.T = 0;
        Exoplanet = rmfield(Exoplanet, 'type');     % Remove 'type' field                     
        Targets{i}(j) = Exoplanet;                  % Create struct with target exoplanets
    end
end
end