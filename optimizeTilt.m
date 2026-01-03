function [sol, fval] = optimizeTilt()
arguments (Output)
    sol (1,1) struct  % solution for the optimization problem based on input
    fval (1,1) double % the objective function value at the solution "sol"
end

% Step 1. Create the optimization problem
% We're telling MATLAB: "We want to MAXIMIZE something."
% That "something" will be energy.
% hint: This MATLAB doc page will be helpful for understanding the
% Optimization Toolbox workflow:
%   https://www.mathworks.com/help/optim/ug/problem-based-workflow.html
% TODO: 
% prob = ?;

% Step 2. Define the optimization variables we can change in the problem
% These are the values MATLAB will try to optimize:
% - theta (tilt angle), must stay between 0 and 90 degrees
% - r (aspect ratio), must stay between 0.5 and 4
% TODO:
% theta = ?;
% r = ?;

% Step 3. Turn our energy function into an optimization problem MATLAB can work
% with.
% This step wraps our energy function so MATLAB can plug in different
% theta and r values while solving the problem.
% note: we're optimizing our energy function, so we should try to convert
% that function into an optimization expression
% TODO:
% Eexpr = ?;

% Step 4. Tell MATLAB what we want to maximize
% We set our energy formula as the "objective" of the problem
% (this is what we want the solver to maximize)
% TODO: 
% prob.Objective = ?;

% Step 5. Give MATLAB a starting point to begin the search
% Optimization needs a guess to start from:
% TODO: ?;  % Start searching from a tilt angle of ? degrees
% TODO: ?;  % Start searching from an aspect ratio of ?

% Step 6. Now solve the problem!
% hint: look for a Optimization Toolbox function meant to solve
% expressions. Store the outputs for plotting purposes later on!
% TODO: for now, return a dummy solution and objective value
sol = struct('theta', 0, 'r', 0);
fval = 0;
end