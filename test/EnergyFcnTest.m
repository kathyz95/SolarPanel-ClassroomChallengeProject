classdef EnergyFcnTest < AbstractSolarPanelOptimizationTest
    % EnergyFcnTest - Unit tests for energyFcn
    %
    % Tests that energyFcn correctly calculates solar panel energy output
    % for various values of theta (tilt angle) and r (aspect ratio).
    %
    % Valid ranges:
    %   theta: 0 to 90 degrees
    %   r: 0.5 to 4
    %
    % Run with: runtests('EnergyFcnTest')
    
    methods (Test)
        function testEnergyIsPositive(testCase)
            % Test that energy is positive for valid inputs
            % This catches unimplemented code that returns 0
            theta = 37.5;
            r = 1.0;
            actual = testCase.runActualFunction('energyFcn', theta, r);
            testCase.verifyGreaterThan(actual, 0, ...
                'Energy should be positive for valid inputs');
        end
        
        function testZeroAngle(testCase)
            % Test energy at theta=0 (panel flat)
            theta = 0;
            r = 1.0;
            expected = testCase.runExpectedFunction('energyFcn', theta, r);
            actual = testCase.runActualFunction('energyFcn', theta, r);
            testCase.verifyEqual(actual, expected, 'AbsTol', 0.01, ...
                sprintf('Energy at theta=0: expected %.2f, got %.2f', expected, actual));
        end
        
        function testMaxAngle(testCase)
            % Test energy at theta=90 (panel vertical)
            theta = 90;
            r = 1.0;
            expected = testCase.runExpectedFunction('energyFcn', theta, r);
            actual = testCase.runActualFunction('energyFcn', theta, r);
            testCase.verifyEqual(actual, expected, 'AbsTol', 0.01, ...
                sprintf('Energy at theta=90: expected %.2f, got %.2f', expected, actual));
        end
        
        function testMinAspectRatio(testCase)
            % Test energy at minimum aspect ratio r=0.5
            theta = 37.5;
            r = 0.5;
            expected = testCase.runExpectedFunction('energyFcn', theta, r);
            actual = testCase.runActualFunction('energyFcn', theta, r);
            testCase.verifyEqual(actual, expected, 'AbsTol', 0.01, ...
                sprintf('Energy at r=0.5: expected %.2f, got %.2f', expected, actual));
        end
        
        function testMaxAspectRatio(testCase)
            % Test energy at maximum aspect ratio r=4
            theta = 37.5;
            r = 4.0;
            expected = testCase.runExpectedFunction('energyFcn', theta, r);
            actual = testCase.runActualFunction('energyFcn', theta, r);
            testCase.verifyEqual(actual, expected, 'AbsTol', 0.01, ...
                sprintf('Energy at r=4: expected %.2f, got %.2f', expected, actual));
        end
        
        function testCornerCases(testCase)
            % Test energy at corner cases of the valid range
            corners = [0, 0.5; 0, 4; 90, 0.5; 90, 4];
            for i = 1:size(corners, 1)
                theta = corners(i, 1);
                r = corners(i, 2);
                expected = testCase.runExpectedFunction('energyFcn', theta, r);
                actual = testCase.runActualFunction('energyFcn', theta, r);
                testCase.verifyEqual(actual, expected, 'AbsTol', 0.01, ...
                    sprintf('Energy at theta=%.1f, r=%.1f: expected %.2f, got %.2f', ...
                    theta, r, expected, actual));
            end
        end
        
        function testMidRangeValues(testCase)
            % Test energy at several mid-range values
            testPoints = [30, 1; 45, 1; 60, 1; 45, 2; 45, 3];
            for i = 1:size(testPoints, 1)
                theta = testPoints(i, 1);
                r = testPoints(i, 2);
                expected = testCase.runExpectedFunction('energyFcn', theta, r);
                actual = testCase.runActualFunction('energyFcn', theta, r);
                testCase.verifyEqual(actual, expected, 'AbsTol', 0.01, ...
                    sprintf('Energy at theta=%.1f, r=%.1f: expected %.2f, got %.2f', ...
                    theta, r, expected, actual));
            end
        end
    end
end
