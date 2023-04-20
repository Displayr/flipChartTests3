[![](https://travis-ci.org/Displayr/flipChartTests3.svg?branch=master)](https://travis-ci.org/Displayr/flipChartTests3/)
[![Coverage Status](https://coveralls.io/repos/github/Displayr/flipChartTests3/badge.svg?branch=master)](https://coveralls.io/github/Displayr/flipChartTests3?branch=master)
# flipChartTests3

This package contains only unit tests for flipStandardChart and flipChart. Test outputs are machine-specific, so it is recommended that you use the image files included inside the repository rather than local versions.

### Checking for snapshot diffs
Tests are run automatically in CircleCI, after a push to flipChartTests3, flipChart, flipStandardCharts or other upstream dependencies. Snapshots will be found in [tests/testthat/snapshots](tests/testthat/snapshots). Diffing files are in the **[diff](tests/testthat/snapshots/diff)** directory and should be compared against files of the same name that are in the **[accepted](tests/testthat/snapshots/accepted)** directory.

### Creating new tests
Tests can be added to the R files in the [testthat](tests/testthat) directory. Convenience functions have been provided in flipChartTests3 so the tests can be created easily. For example,
```
pp <- plot_ly(x = 1:10, y = 1:10, trace = "scatter")
expect_true(TestWidget(pp, "test1"))
```
Only the test file (e.g. tests/testthat/test-background.R) should be committed, not the test outputs (PNG files).

## Running tests locally
The output from running tests locally are not reliable, and should be compared against the output in [CircleCI](https://app.circleci.com/pipelines/github/Displayr/flipChartTests3). If working locally, the dependencies can be set up by
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

## Installation

To install from GitHub:
```
require(devtools)
install_github("Displayr/flipChartTests3", dependencies = NA)
```

If you have not set up a GitHub Personal Access Token, you will likely need to do so to avoid
GitHub rate limits, which will manifest as 403 errors when downloading packages via
`install_github`. Please see the documentation in the `usethis` package or see the
instructions [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) and [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).

If you are using Windows, you will need to have a version of Rtools installed that matches your
version of R in order to build packages from source. Rtools can be downloaded from
[here](https://cran.r-project.org/bin/windows/Rtools/).

Specifying `dependencies = NA` in `install_github` will not install packages listed
in `Suggests` in the `DESCRIPTION` file (some of which may be proprietary and unavailable for download).

## Submitting a bug report

If you encounter a problem using the package, please open an [issue](https://github.com/Displayr/flipChartTests3/issues). To achieve a resolution as quickly as possible, please include a minimal, reproducible example of the bug, along with the exact error message or output you receive and the behavior you expect. Including the output of `sessionInfo()` in R can be helpful to reproduce the issue. Please see this [FAQ](https://community.rstudio.com/t/faq-whats-a-reproducible-example-reprex-and-how-do-i-create-one/5219), which has a number of useful tips on creating great reproducible examples.

[![Displayr logo](https://mwmclean.github.io/img/logo-header.png)](https://www.displayr.com)
