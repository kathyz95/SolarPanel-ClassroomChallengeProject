function [theta_grid, r_grid, E_grid] = plotData(sol, fval)
arguments (Input)
    sol (1,1) struct  % solution for the energy optimization problem
    fval (1,1) double {mustBeNumeric}  % the objective function value at the solution
end

% Print the results to the screen
fprintf('Optimal Tilt Angle: %.2f deg\n', sol.theta);
fprintf('Optimal Aspect Ratio: %.2f\n', sol.r);
fprintf('Maximum Energy Output: %.2f units\n', fval);

% 6. graph

% make a bunch of points for the x and y axis 
% the step for the angle is 1, the step for ratio is 0.1
[theta_grid, r_grid] = meshgrid(0:1:90, 0.5:0.1:4);

% now calculate the energy for every single point on my grid
E_grid = (2 * cosd(theta_grid - 30) .* (1000 * cosd(theta_grid - 45)) .* exp(-0.1 * (r_grid - 1).^2));

% draw the 3d graph
surf(theta_grid, r_grid, E_grid, 'EdgeColor', 'none');

% label everything
title('Solar Panel Energy');
xlabel('Angle (theta)');
ylabel('Aspect Ratio (r)');
zlabel('Energy');
colorbar;

% put a star on the plot to show where the most optimal point is
hold on;
plot3(sol.theta, sol.r, fval, '*', 'MarkerSize', 25);

end
