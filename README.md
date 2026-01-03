# Optimization: Maximize the Solar Panel Output for a Fixed Area

## Objective

Use MATLAB to formulate and solve an optimization problem: Given a fixed area, determine the optimal tilt angle and aspect ratio of a solar panel to maximize the total energy output.

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=adkrueger/SolarPanelChallenge&file=SolarPanelOptimization.mlx)

## Background

Solar panel efficiency depends on:
- The tilt angle with respect to the sun
- The shape (aspect ratio) of the panel
- The available area for installation

The goal is to apply numerical optimization techniques in MATLAB to find the best configuration that maximizes energy output under simplified assumptions.

## Problem Description

You have a total area of 2 square meters to place a solar panel. The panel can have any rectangular shape but must stay within this total area.

The total energy output (in simplified units) can be approximated as:

$$E(\theta, r) = A \cdot \eta(\theta) \cdot sunIntensity(\theta) \cdot f(r)$$

Where:
- **A = 2 m²** (fixed area)
- **θ ∈ [0°, 90°]** is the tilt angle (in degrees)
- **r** is the aspect ratio (length/width), with r ∈ [0.5, 4]
- **η(θ) = cos(θ − 30°)** (efficiency function)
- **sunIntensity(θ) = 1000 · cos(θ − 45°)** (sunlight variation with tilt)
- **f(r) = exp(−0.1 · (r − 1)²)** (efficiency drops for extreme shapes)

Your task: Find the optimal θ and r that maximize E(θ, r).

## Tasks

1. Define the objective function in MATLAB: `E = @(x)...` where x(1)=theta, x(2)=r.
2. Use `fmincon` to find the values of theta and r that maximize the energy output.
   - Hint: Minimize `-E(x)` instead.
3. Constrain the values:
   - 0 ≤ θ ≤ π/2
   - 0.5 ≤ r ≤ 4
4. Plot the objective function using `fsurf` or a mesh plot to visualize E(θ, r).
5. Print the optimal angle, ratio, and corresponding energy output.

## Sample Output

- **Optimal Tilt Angle:** 39.8 degrees
- **Optimal Aspect Ratio:** 1.2
- **Maximum Energy Output:** 1895.3 units

## Learning Outcomes

- Formulate a real-world problem as a mathematical optimization problem
- Use MATLAB's `fmincon` for constrained nonlinear optimization
- Visualize and interpret multivariable objective functions

## Background Material

- [MATLAB Onramp](https://matlabacademy.mathworks.com/details/matlab-onramp/gettingstarted)
- [Optimization Onramp](https://matlabacademy.mathworks.com/details/optimization-onramp/optim)
