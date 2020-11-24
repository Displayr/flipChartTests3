context("Bar gaps")
library("flipStandardCharts")
library("flipChartTests")

# Data sets to check
# These tests are based on test-stacked.R
# But include more charting options not available for stacked charts
# e.g. negative values and lines of best fit
set.seed(654321)
unnamed <- matrix(rpois(60, 4), 20, 3) # all positives
named <- matrix(unnamed, 20, 3, dimnames = list(letters[1:20], LETTERS[1:3]))
signed <- sweep(named, 1, rnorm(2), "*")
signed2 <- matrix(rnorm(30), 10, 3)
gapped <- matrix(unnamed, 20, 3, dimnames = list(c(1:10, 21:30), LETTERS[1:3]))
missing1 <- gapped
missing1[1,1] <- NA
rownames(missing1) <- 25:44
missing124 <- missing1
missing124[c(1,2,4),1] <- NA
dated <- gapped
rownames(dated) <- sprintf("%02d/01/2017", 1:20)
gapdated <- dated
rownames(gapdated) <- sprintf("%02d/01/2017", c(1:10, 21:30))


# Set up combinations to iterate tests through
charting.funcs <- c("Bar", "Column") #, "Pyramid")
dat.list <- c("unnamed", "named", "gapped", "dated", "gapdated")
opts <- c('g05' = 'bar.gap = 0.05',
          's05' = 'bar.gap = 0.05, type = "Stacked"',
          'g8d' = 'bar.gap = 0.8, data.label.show = TRUE, fit.type = "supsmu"',
          's8d' = 'bar.gap = 0.8, data.label.show = TRUE, type = "Stacked"',
          'g4r' = 'bar.gap = 0.4, data.label.show = TRUE, x.data.reversed = TRUE',
          's4r' = 'bar.gap = 0.4, data.label.show = TRUE, x.data.reversed = TRUE, type = "Stacked"')

# data axis of stacked area chart gets chopped off
for (dat in dat.list)
{
    for (func in charting.funcs)
    {
        for (ii in 1:length(opts))
        {
            filestem <- paste("bargap", tolower(func), dat, names(opts)[ii], sep="-")
            test_that(filestem, {

                cmd <- paste0("pp <- ", func, "(", dat, "," , opts[ii], ")")
                expect_error(eval(parse(text=cmd)), NA)
                expect_true(TestWidget(pp, filestem, delay = 2))
            })

            if (substr(names(opts)[ii], 1, 1) == "g")
            {
                filestem <- paste("bargap", tolower(func), "sm", dat, names(opts)[ii], sep="-")
                test_that(filestem, {
                    cmd <- paste0("pp <- SmallMultiples(", dat, ", '", func, "', " , opts[ii], ")")
                    expect_error(eval(parse(text=cmd)), NA)
                    expect_true(TestWidget(pp, filestem, delay = 2))
                })
            }
        }
    }
}

