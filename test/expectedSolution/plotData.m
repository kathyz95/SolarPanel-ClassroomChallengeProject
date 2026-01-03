function [theta_grid, r_grid, E_grid] = plotData(sol, fval)
arguments (Input)
    sol (1,1) struct  % solution for the energy optimization problem
    fval (1,1) double % the objective function value at the solution
end

% Step 1: Make a bunch of points for the x and y axis meshgrid
% the step for the angle is 1, the step for ratio is 0.1
% hint: keep theta and r within the bounds specified in task 3
thetaVals = 0:1:90;
rVals = 0.5:0.1:4;
[theta_grid, r_grid] = meshgrid(thetaVals, rVals);

% Step 2: Replace with the right formula to calculate energy for every point on the meshgrid using element-wise operations
% hint: this is very similar to energyFcn, but we're applying it to the
% matrices we just created with meshgrid.
% Look at how to apply functions to matrices, or you may consider using element-wise
% multiplication, see here:
% https://www.mathworks.com/help/matlab/ref/double.times.html
E_grid = arrayfun(@(t,r)energyFcn(t,r), theta_grid, r_grid);
% Element-wise operation answer
% E_grid = (2 * cosd(theta_grid - 30) .* (1000 * cosd(theta_grid - 45)) .* exp(-0.1 * (r_grid - 1).^2));

% Step 3: Draw the 3d graph using the "surf" function
% hint: consider looking at the "EdgeColor" parameter if it doesn't turn
% out "pretty" :-)
surf(theta_grid, r_grid, E_grid, 'EdgeColor', 'none');

% Step 4: label everything on the surf plot using title, xlabel, ylabel, zlabel, and colorbar
title('Solar Panel Energy');
xlabel('Angle (theta)');
ylabel('Aspect Ratio (r)');
zlabel('Energy');
colorbar;

% Step 5:  Mark the optimal point on the plot
% hint: you will need a MATLAB plot function that lets you plot coordinates
% in 3-D space.
% hint: remember the outputs of the function used to solve the optimization
% problem!
% hint: watch out for overwriting your existing plot!
hold on;
plot3(sol.theta, sol.r, fval, '*', 'MarkerSize', 25);
