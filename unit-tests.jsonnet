local testCases = import './tests/tests.libsonnet';

local runTest(t) = {
  result:: t[2] == t[1],
  success: if self.result then self.result else std.trace('FAILED: %s \n - EXPECTED: %s \n - ACTUAL:   %s' % [t[0], t[2], t[1]], self.result),
};

local testResults = std.map(runTest, testCases);

local failures = std.filter(function(result) !result.success, testResults);
local failureCount = std.length(failures);

local successes = std.filter(function(result) result.success, testResults);
local successCount = std.length(successes);

if failureCount == 1 then
  'There is %s test failing.' % failureCount
else if failureCount > 1 then
  'There are %s tests failing.' % failureCount
else
  'OK - %s Tests' % successCount
