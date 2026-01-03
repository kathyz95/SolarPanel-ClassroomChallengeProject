function E = energyFcn(theta, r)
arguments (Input)
    theta (1,1) double  % tilt angle in degrees
    r (1,1) double % aspect ratio (width/height)
end

arguments (Output)
    E (1,1) double % energy output of the solar panel
end

% Energy is based on cosine of angle differences and shape efficiency
% See README.pdf Problem Description for the energy formula

% Step 1: Define A (panel area in m^2)
% TODO: replace dummy value
A = 0;

% Step 2: Define nu (efficiency function based on tilt angle)
% TODO: replace dummy value
nu = 0;

% Step 3: Define sunIntensity (sunlight variation with tilt)
% TODO: replace dummy value
sunIntensity = 0;

% Step 4: Define fr (shape efficiency factor based on aspect ratio)
% TODO: replace dummy value
fr = 0;

% Step 5: Calculate E (total energy output)
% TODO: replace dummy value
E = 0;
end
