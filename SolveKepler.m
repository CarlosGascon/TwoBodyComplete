function [x0] = SolveKepler(M, e)
% Description: The following function solves the kepler equation for the
% values of mean motion M and eccentricity e given. The minimum relative
% error or tolerane is fixed by 'tol', and the maximum number of
% interations is given by MaxIter. 

% Input:
    % - All: Input is formed by the mean anomaly M in radians and the
    % eccentricity e.
% Output: 
    % - x0: Solution of the equation

f = @(x) x - e * sin(x) - M;         % Define zero function
df = @(x) 1 - e * cos(x);            % Define zero function derivative

MaxIter = 1e3;                       % Set Maximum number of iterations
tol = 10e-5;                         % Set tolerance
r = tol + 1;                         % Initialize relative error
x0 = M;                             
k = 0;

while r > tol && k < MaxIter         % Iterate until achieved tolerance or MaxIter
    k = k + 1;                       % Update number of iterations
    x1 = x0 - f(x0) / df(x0);        % Compute new point
    r = abs((x1 - x0) / x1);         % Calculate relative erro
    x0 = x1;                         % Update 
end

if k == MaxIter
    fprintf('Warning'); 
end

end

