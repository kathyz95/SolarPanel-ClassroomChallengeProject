function [theta_grid, r_grid, E_grid] = plotData(sol, fval)
arguments (Input)
    sol (1,1) struct  % solution for the energy optimization problem
    fval (1,1) double % the objective function value at the solution
end

% Step 1: Make a bunch of points for the x and y axis meshgrid
% the step for the angle is 1, the step for ratio is 0.1
% hint: keep theta and r within the bounds specified in task 3
thetaVals = 0:1:1; % TODO: replace with appropriate range for theta
rVals = 0:0.1:1; % TODO: replace with appropriate range for r
[theta_grid, r_grid] = meshgrid(thetaVals, rVals);
% TODO

% Step 2: Replace with the right formula to calculate energy for every point on the meshgrid using element-wise operations
% hint: this is very similar to energyFcn, but we're applying it to the
% matrices we just created with meshgrid.
% Look at how to apply functions to matrices, or you may consider using element-wise
% multiplication, see here:
% https://www.mathworks.com/help/matlab/ref/double.times.html
E_grid = zeros(size(theta_grid));
% TODO

% Step 3: Draw the 3d graph using the "surf" function
% hint: consider looking at the "EdgeColor" parameter if it doesn't turn
% out "pretty" :-)
% TODO

% Step 4: label everything on the surf plot using title, xlabel, ylabel, zlabel, and colorbar
% TODO

% Step 5:  Mark the optimal point on the plot
% hint: you will need a MATLAB plot function that lets you plot coordinates
% in 3-D space.
% hint: remember the outputs of the function used to solve the optimization
% problem!
% hint: watch out for overwriting your existing plot!
% TODO
