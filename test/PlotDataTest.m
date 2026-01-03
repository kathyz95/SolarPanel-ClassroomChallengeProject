classdef plotDataTest < AbstractSolarPanelOptimizationTest
    % plotDataTest - Unit tests for plotData
    %
    % Tests that plotData correctly creates a 3D surface plot
    % of the solar panel energy function and marks the optimal point.
    %
    % Expected behavior:
    %   - Creates meshgrid for theta (0:1:90) and r (0.5:0.1:4)
    %   - Calculates energy for each grid point
    %   - Plots surface with surf()
    %   - Marks optimal point with plot3()
    %
    % Run with: runtests('plotDataTest')
    
    properties (Access = private)
        TestSol             % Test solution struct
        TestFval            % Test objective value
        FiguresBeforeTest   % Figures open before test runs
        ExpectedThetaGrid   % Expected theta_grid from expected impl
        ExpectedRGrid       % Expected r_grid from expected impl
        ExpectedEGrid       % Expected E_grid from expected impl
    end
    
    methods (TestClassSetup)
        function setupTestData(testCase)
            % Get test solution data from expected implementation
            [testCase.TestSol, testCase.TestFval] = testCase.runExpectedFunction('optimizeTilt');
            
            % Run expected plotData to get reference outputs
            [testCase.ExpectedThetaGrid, testCase.ExpectedRGrid, testCase.ExpectedEGrid] = ...
                testCase.runExpectedFunction('plotData', testCase.TestSol, testCase.TestFval);
            close(gcf);  % Close the expected figure
        end
    end

    methods (TestMethodSetup)
        function trackExistingFigures(testCase)
            % Track figures open before test
            testCase.FiguresBeforeTest = findall(0, 'Type', 'figure');
            
            % Register cleanup to close only new figures
            testCase.addTeardown(@() closeNewFigures(testCase));
        end
    end
    
    methods (Access = private)
        function closeNewFigures(testCase)
            % Close only figures created during the test
            figuresAfterTest = findall(0, 'Type', 'figure');
            newFigures = setdiff(figuresAfterTest, testCase.FiguresBeforeTest);
            close(newFigures);
        end
        
        function [surfObj, ax] = runAndAssertFigureCreated(testCase)
            % Run function and assert a figure with surface was created
            initialFigCount = length(findall(0, 'Type', 'figure'));
            testCase.runActualFunction('plotData', testCase.TestSol, testCase.TestFval);
            finalFigCount = length(findall(0, 'Type', 'figure'));
            testCase.assertTrue(finalFigCount > initialFigCount, ...
                'plotData must create a figure');
            
            ax = gca;
            surfObjs = findall(ax, 'Type', 'surface');
            testCase.assertTrue(~isempty(surfObjs), ...
                'plotData must create a surface plot');
            surfObj = surfObjs(1);
        end
    end
    
    methods (Test)
        function testStep1_MeshgridHasCorrectSize(testCase)
            [actualThetaGrid, actualRGrid, ~] = ...
                testCase.runActualFunction('plotData', testCase.TestSol, testCase.TestFval);

            expectedSize = size(testCase.ExpectedThetaGrid);
            actualSize = size(actualThetaGrid);
            testCase.verifyEqual(actualSize, expectedSize, ...
                sprintf('Meshgrid size: expected [%d, %d], got [%d, %d]', ...
                expectedSize(1), expectedSize(2), actualSize(1), actualSize(2)));

            expectedSize = size(testCase.ExpectedRGrid);
            actualSize = size(actualRGrid);
            testCase.verifyEqual(actualSize, expectedSize, ...
                sprintf('Meshgrid size: expected [%d, %d], got [%d, %d]', ...
                expectedSize(1), expectedSize(2), actualSize(1), actualSize(2)));

            testCase.verifyEqual(actualThetaGrid, testCase.ExpectedThetaGrid, ...
                'theta_grid should match expected values');
            
            testCase.verifyEqual(actualRGrid, testCase.ExpectedRGrid, ...
                'r_grid should match expected values');
        end
        
        function testStep2_EnergyValuesArePositive(testCase)
            [~, ~, actualEGrid] = ...
                testCase.runActualFunction('plotData', testCase.TestSol, testCase.TestFval);

            testCase.verifyGreaterThan(max(actualEGrid(:)), 0, ...
                'E_grid should have positive values (not all zeros)');

            testCase.verifyEqual(actualEGrid, testCase.ExpectedEGrid, 'RelTol', 0.01, ...
                'E_grid values should match expected implementation');
        end
        
        function testStep3_SurfPlotCreated(testCase)
            [surfObj, ~] = testCase.runAndAssertFigureCreated();
            
            % Verify the surf plot contains the correct data
            actualXData = get(surfObj, 'XData');
            actualYData = get(surfObj, 'YData');
            actualZData = get(surfObj, 'ZData');
            
            testCase.verifyEqual(actualXData, testCase.ExpectedThetaGrid, ...
                'surf XData (theta_grid) should match expected values');
            testCase.verifyEqual(actualYData, testCase.ExpectedRGrid, ...
                'surf YData (r_grid) should match expected values');
            testCase.verifyEqual(actualZData, testCase.ExpectedEGrid, 'RelTol', 0.01, ...
                'surf ZData (E_grid) should match expected values');
        end
        
        function testStep4_PlotHasAxisLabels(testCase)
            [~, ax] = testCase.runAndAssertFigureCreated();

            title = get(get(ax, 'Title'), 'String');
            xLabel = get(get(ax, 'XLabel'), 'String');
            yLabel = get(get(ax, 'YLabel'), 'String');
            zLabel = get(get(ax, 'ZLabel'), 'String');
            testCase.verifyNotEmpty(title, 'Plot should have a title');
            testCase.verifyNotEmpty(xLabel, 'Plot should have x-axis label');
            testCase.verifyNotEmpty(yLabel, 'Plot should have y-axis label');
            testCase.verifyNotEmpty(zLabel, 'Plot should have z-axis label');

            colorbarObjs = findall(gcf, 'Type', 'colorbar');
            testCase.verifyNotEmpty(colorbarObjs, 'Plot should have a colorbar');
        end
        
        function testStep5_OptimalPointIsMarked(testCase)
            [~, ax] = testCase.runAndAssertFigureCreated();
            lineObjs = findall(ax, 'Type', 'line');
            testCase.assertTrue(~isempty(lineObjs), ...
                'Optimal point must be marked with plot3');
            
            % Verify the marker is at the correct location
            markerX = get(lineObjs(1), 'XData');
            markerY = get(lineObjs(1), 'YData');
            markerZ = get(lineObjs(1), 'ZData');

            testCase.NumElements(markerX, 1, "Expected a single optimal point to be marked on the surface.");
            testCase.NumElements(markerY, 1, "Expected a single optimal point to be marked on the surface.");
            testCase.NumElements(markerZ, 1, "Expected a single optimal point to be marked on the surface.");
            
            testCase.verifyEqual(markerX, testCase.TestSol.theta, 'AbsTol', 0.01, ...
                sprintf('Marker X should be at optimal theta=%.2f, got %.2f', ...
                testCase.TestSol.theta, markerX));
            testCase.verifyEqual(markerY, testCase.TestSol.r, 'AbsTol', 0.01, ...
                sprintf('Marker Y should be at optimal r=%.2f, got %.2f', ...
                testCase.TestSol.r, markerY));
            testCase.verifyEqual(markerZ, testCase.TestFval, 'RelTol', 0.01, ...
                sprintf('Marker Z should be at optimal fval=%.2f, got %.2f', ...
                testCase.TestFval, markerZ));
        end
    end
end
