## Old travis timings from
## https://app.travis-ci.com/github/Displayr/flipChartTests3/builds/260585134
## test-bargap.R: 343s
## test-datalabelmatrix.R: 103s
## test-matrixdata.R: 704s
## test-multicolor.R: 300.9
## test-smallmult-chart.R: 614
## test-stacked.R: 130
## test-vectordata.R: 654 
if (identical(Sys.getenv("CIRCLECI"), "true"))
{
    if (!dir.exists("reports"))
        dir.create("reports")
    out.file <- paste0("reports/test_results", Sys.getenv("CIRCLE_NODE_INDEX"), ".xml")
    exit.code <- flipDevTools::RunTestsOnCircleCI(filter = "^matrix",
                                                  load_package = "none", output_file = out.file)
    ## Ignore exit code so job continues to save snapshot step
    ## q(status = exit.code, save = "no")
}
