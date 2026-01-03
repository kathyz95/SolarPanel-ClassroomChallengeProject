classdef OptimizeTiltTest < AbstractSolarPanelOptimizationTest
    % OptimizeTiltTest - Unit tests for optimizeTilt
    %
    % Tests that optimizeTilt correctly finds the optimal tilt angle and
    % aspect ratio that maximize solar panel energy output.
    %
    % Expected optimal values (approximate):
    %   theta: ~37.5 degrees
    %   r: ~1.0
    %   fval: ~1965.93 units
    %
    % Run with: runtests('OptimizeTiltTest')
    
    methods (Test)
        function testFvalIsPositive(testCase)
            % Test that fval is positive for a working implementation
            % This catches unimplemented code that returns 0
            [~, fval] = testCase.runActualFunction('optimizeTilt');
            testCase.verifyGreaterThan(fval, 0, ...
                'Objective function value (fval) should be positive');
        end
        
        function testThetaIsPositive(testCase)
            % Test that optimal theta is positive
            % This catches unimplemented code that returns 0
            [sol, ~] = testCase.runActualFunction('optimizeTilt');
            testCase.verifyGreaterThan(sol.theta, 0, ...
                'Optimal theta should be positive');
        end
        
        function testOptimalTheta(testCase)
            % Test that optimal theta matches expected value
            [expectedSol, ~] = testCase.runExpectedFunction('optimizeTilt');
            [actualSol, ~] = testCase.runActualFunction('optimizeTilt');
            testCase.verifyEqual(actualSol.theta, expectedSol.theta, 'AbsTol', 0.5, ...
                sprintf('Optimal theta: expected %.2f, got %.2f', ...
                expectedSol.theta, actualSol.theta));
        end
        
        function testOptimalR(testCase)
            % Test that optimal aspect ratio matches expected value
            [expectedSol, ~] = testCase.runExpectedFunction('optimizeTilt');
            [actualSol, ~] = testCase.runActualFunction('optimizeTilt');
            testCase.verifyEqual(actualSol.r, expectedSol.r, 'AbsTol', 0.1, ...
                sprintf('Optimal r: expected %.2f, got %.2f', ...
                expectedSol.r, actualSol.r));
        end
        
        function testOptimalFval(testCase)
            % Test that maximum energy matches expected value
            [~, expectedFval] = testCase.runExpectedFunction('optimizeTilt');
            [~, actualFval] = testCase.runActualFunction('optimizeTilt');
            testCase.verifyEqual(actualFval, expectedFval, 'RelTol', 0.01, ...
                sprintf('Maximum energy: expected %.2f, got %.2f', ...
                expectedFval, actualFval));
        end
        
        function testThetaInBounds(testCase)
            % Test that optimal theta is within valid bounds [0, 90]
            [sol, ~] = testCase.runActualFunction('optimizeTilt');
            testCase.verifyGreaterThanOrEqual(sol.theta, 0, ...
                'Optimal theta should be >= 0');
            testCase.verifyLessThanOrEqual(sol.theta, 90, ...
                'Optimal theta should be <= 90');
        end
        
        function testRInBounds(testCase)
            % Test that optimal r is within valid bounds [0.5, 4]
            [sol, ~] = testCase.runActualFunction('optimizeTilt');
            testCase.verifyGreaterThanOrEqual(sol.r, 0.5, ...
                'Optimal r should be >= 0.5');
            testCase.verifyLessThanOrEqual(sol.r, 4, ...
                'Optimal r should be <= 4');
        end
        
        function testSolutionStructureHasRequiredFields(testCase)
            % Test that sol struct has theta and r fields
            [sol, ~] = testCase.runActualFunction('optimizeTilt');
            testCase.verifyTrue(isfield(sol, 'theta'), ...
                'Solution struct should have theta field');
            testCase.verifyTrue(isfield(sol, 'r'), ...
                'Solution struct should have r field');
        end
    end
end
