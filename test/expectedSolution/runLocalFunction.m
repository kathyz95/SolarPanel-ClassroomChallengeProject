function result = runLocalFunction(targetDir, funcName, varargin)
% runLocalFunction Execute a function from a specific directory
%   result = runLocalFunction(targetDir, funcName, arg1, arg2, ...)
%   Temporarily adds targetDir to path and runs the function there.

% Save current state
originalPath = path;
originalDir = pwd;

% Setup cleanup to restore state
cleanup = onCleanup(@() restorePathAndDir(originalPath, originalDir));

% Change to target directory and update path
cd(targetDir);
addpath(targetDir);

% Get function handle and execute
funcHandle = str2func(funcName);
result = funcHandle(varargin{:});
end

function restorePathAndDir(originalPath, originalDir)
    path(originalPath);
    cd(originalDir);
end
