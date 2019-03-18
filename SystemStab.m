function [Stab, a, e] = SystemStab(Target, m)
% Description:

% Input:

% Output:

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

end

