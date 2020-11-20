[![](https://travis-ci.org/Displayr/flipChartTests.svg?branch=master)](https://travis-ci.org/Displayr/flipChartTests/)
# flipChartTests

This package contains only unit tests for flipStandardChart and flipChart. Test outputs are machine-specific, so it is recommended that you use the image files included inside the repository rather than local versions.

### Checking for snapshot diffs
Tests are run automatically in TravisCI, after a push to flipChartTests, flipChart, flipStandardCharts or other upstream dependencies. Snapshots will be found in [tests/testthat/snapshots](tests/testthat/snapshots). Diffing files are in the **[diff](tests/testthat/snapshots/diff)** directory and should be compared against files of the same name that are in the **[accepted](tests/testthat/snapshots/accepted)** directory.

### Creating new tests
Tests can be added to the R files in the [testthat](tests/testthat) directory. Convenience functions have been provided in flipChartTests so the tests can be created easily. For example,
```
pp <- plot_ly(x = 1:10, y = 1:10, trace = "scatter")
expect_true(TestWidget(pp, "test1"))
```
Only the test file (e.g. tests/testthat/test-background.R) should be committed, not the test outputs (PNG files).

## Running tests locally
The output from running tests locally are not reliable, and should be compared against the output in [TravisCI](https://travis-ci.org/Displayr/flipChartTests). If working locally, the dependencies can be set up by
```
install.packages("devtools")
install.packages("testthat")
require(devtools)
install_github("MangoTheCat/visualTest")
install.packages("webshot")
webshot::install_phantomjs()
```
Because the snapshots are machine-specific, the first time they are run locally, you may need to delete all files inside [tests/testthat/snapshots/accepted](tests/testthat/snapshots/accepted) before regenerating.

To accept new test outputs, simply delete the existing test output inside [tests/testthat/snapshots/accepted](tests/testthat/snapshots/accepted) and the new outputs will saved in that directory next time the tests are run using `devtools::test()` or `testthat_test_file(<filename>)` to run a subset of tests.

Note that you should use `devtools::test()` rather than `devtools::check()` as `check()` will give the same errors and warning but will not generate output PNG files in the repository.

[![Displayr logo](https://mwmclean.github.io/img/logo-header.png)](https://www.displayr.com)
