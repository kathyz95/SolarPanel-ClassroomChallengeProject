function [sol, fval] = optimizeTilt()
arguments (Output)
    sol (1,1) struct  % solution for the optimization problem based on input
    fval (1,1) double {mustBeNumeric}  % the objective function value at the solution
end

% 1. Create the optimization problem
% We're telling MATLAB: "We want to MAXIMIZE something."
% That "something" will be energy.
prob = optimproblem('ObjectiveSense','maximize');

% 2. Define the variables we can change in the problem
% These are the values MATLAB will try to optimize:
% - theta (tilt angle), must stay between 0 and 90 degrees
% - r (aspect ratio), must stay between 0.5 and 4
theta = optimvar('theta','LowerBound',0,'UpperBound',90);
r = optimvar('r','LowerBound',0.5,'UpperBound',4);

% 3. Turn our energy function into something MATLAB can work with
% This step wraps our energy function so MATLAB can plug in different
% theta and r values while solving the problem.
% Get function handle to expected energyFcn in same directory
expectedDir = fileparts(mfilename('fullpath'));
energyFcnHandle = @(t, r) runLocalFunction(expectedDir, 'energyFcn', t, r);
Eexpr = fcn2optimexpr(energyFcnHandle, theta, r);  % Convert our function into an expression

% 4. Tell MATLAB what we want to maximize
% We set our energy formula as the "objective" of the problem
% (this is what we want the solver to maximize)
prob.Objective = Eexpr;

% 5. Give MATLAB a starting point to begin the search
% Optimization needs a guess to start from:
x0.theta = 30;  % Start searching from a tilt angle of 30 degrees
x0.r = 1;       % Start searching from an aspect ratio of 1

% Now solve the problem!
[sol, fval] = solve(prob, x0);
end
