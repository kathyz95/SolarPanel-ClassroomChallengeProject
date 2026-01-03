classdef (Abstract) AbstractSolarPanelOptimizationTest < matlab.unittest.TestCase
    % AbstractSolarPanelOptimizationTest Base class for Solar Panel Optimization tests
    %   Provides common setup/teardown and helper methods for running
    %   actual vs expected function implementations.
    
    properties (Constant)
        RelativeTolerance = 0.01   % 1% relative tolerance for numeric comparisons
        AbsoluteTolerance = 1e-6  % Absolute tolerance for near-zero values
    end
    
    properties (Access = protected)
        OriginalPath    % Store original MATLAB path
        OriginalDir     % Store original working directory
        TestDir         % Path to test directory
        ExpectedDir     % Path to expectedSolution directory
        ActualDir       % Path to actual (student) implementation directory
    end
    
    methods (TestClassSetup)
        function setupPaths(testCase)
            % Store original state for cleanup
            testCase.OriginalPath = path;
            testCase.OriginalDir = pwd;
            
            % Determine directory paths
            testCase.TestDir = fileparts(mfilename('fullpath'));
            testCase.ExpectedDir = fullfile(testCase.TestDir, 'expectedSolution');
            testCase.ActualDir = fileparts(testCase.TestDir);  % Parent of test dir
            
            % Ensure cleanup happens even if tests fail
            testCase.addTeardown(@() restoreState(testCase));
        end
    end
    
    methods (Access = protected)
        function varargout = runActualFunction(testCase, funcName, varargin)
            % runActualFunction Execute the student's implementation
            %   result = runActualFunction(testCase, funcName, arg1, arg2, ...)
            %   [out1, out2] = runActualFunction(testCase, funcName, ...)
            %   Temporarily adds the actual implementation to path and runs it.
            
            [varargout{1:nargout}] = testCase.runFunctionInDir(testCase.ActualDir, funcName, nargout, varargin{:});
        end
        
        function varargout = runExpectedFunction(testCase, funcName, varargin)
            % runExpectedFunction Execute the expected (solution) implementation
            %   result = runExpectedFunction(testCase, funcName, arg1, arg2, ...)
            %   [out1, out2] = runExpectedFunction(testCase, funcName, ...)
            %   Temporarily adds the expected implementation to path and runs it.
            
            [varargout{1:nargout}] = testCase.runFunctionInDir(testCase.ExpectedDir, funcName, nargout, varargin{:});
        end
        
        function [actualResult, expectedResult] = runBothImplementations(testCase, funcName, varargin)
            % runBothImplementations Run both actual and expected implementations
            %   [actual, expected] = runBothImplementations(testCase, funcName, args...)
            
            arguments
                testCase (1,1) AbstractSolarPanelOptimizationTest
                funcName (1,1) string {mustBeNonzeroLengthText}
            end
            arguments (Repeating)
                varargin
            end
            
            expectedResult = testCase.runExpectedFunction(funcName, varargin{:});
            actualResult = testCase.runActualFunction(funcName, varargin{:});
        end
        
        function verifyEqualWithTolerance(testCase, actual, expected, diagnostic)
            % verifyEqualWithTolerance Verify numeric values are equal within tolerance
            
            arguments
                testCase (1,1) AbstractSolarPanelOptimizationTest
                actual double
                expected double
                diagnostic (1,1) string = "Values should be equal within tolerance"
            end
            
            testCase.verifyEqual(actual, expected, ...
                'RelTol', testCase.RelativeTolerance, ...
                'AbsTol', testCase.AbsoluteTolerance, ...
                diagnostic);
        end
    end
    
    methods (Access = private)
        function varargout = runFunctionInDir(testCase, targetDir, funcName, numOutputs, varargin)
            % runFunctionInDir Execute a function after temporarily changing to target directory
            %   numOutputs specifies how many outputs to capture
            
            % Save current state
            originalPath = path;
            originalDir = pwd;
            
            % Setup cleanup to restore state even if function errors
            cleanup = onCleanup(@() restorePathAndDir(originalPath, originalDir));
            
            % Change to target directory and update path
            cd(targetDir);
            addpath(targetDir);
            
            % Clear the function from memory to ensure fresh load
            clear(char(funcName));
            
            % Get function handle and execute
            funcHandle = str2func(funcName);
            
            % Call function and capture requested number of outputs
            if numOutputs == 0
                funcHandle(varargin{:});
            else
                [varargout{1:numOutputs}] = funcHandle(varargin{:});
            end
        end
        
        function restoreState(testCase)
            % Restore original MATLAB state
            path(testCase.OriginalPath);
            cd(testCase.OriginalDir);
        end
    end
end

function restorePathAndDir(originalPath, originalDir)
    % Helper function for onCleanup
    path(originalPath);
    cd(originalDir);
end
