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
    % constant area of 2 m^2
    A = 2;
    
    % Step 2: Define nu (efficiency function based on tilt angle)
    nu = cosd(theta - 30);
    
    % Step 3: Define sunIntensity (sunlight variation with tilt)
    sunIntensity = 1000 * cosd(theta - 45);
    
    % Step 4: Define fr (shape efficiency factor based on aspect ratio)
    fr = exp(-0.1 * (r - 1)^2);
    
    % Step 5: Calculate E (total energy output)
    E = A * nu * sunIntensity * fr;
end
