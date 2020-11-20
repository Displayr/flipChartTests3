context("Stacked Charts")

# data sets to check
set.seed(122333)
dat.list <- c("unnamed", "named", "gapped", "missing1", "missing13", "dated", "gapdated")
unnamed <- matrix(rpois(60, 4), 20, 3) # all positives
named <- matrix(unnamed, 20, 3, dimnames = list(letters[1:20], LETTERS[1:3]))
gapped <- matrix(unnamed, 20, 3, dimnames = list(c(1:10, 21:30), LETTERS[1:3]))
missing1 <- gapped
missing1[1,1] <- NA
rownames(missing1) <- 25:44
missing13 <- missing1
missing13[c(1,3),1] <- NA
dated <- gapped
rownames(dated) <- sprintf("%02d/01/2017", 1:20)
gapdated <- dated
rownames(gapdated) <- sprintf("%02d/01/2017", c(1:10, 21:30))

opts <- c('default' = '',
          'datalabels' = 'data.label.show = TRUE',
          'reversed' = 'x.data.reversed = TRUE, y.data.reversed = TRUE, data.label.show = TRUE',
          'vertcenterlabels' = 'data.label.show = TRUE, data.label.centered = TRUE',
          'vertcenterlabelsrev' = 'data.label.show = TRUE, data.label.centered = TRUE, x.data.reversed = TRUE, y.data.reversed = TRUE')

# data axis of stacked area chart gets chopped off
for (func in c("Area", "Bar", "Column")[3])
{
    for (dat in dat.list)
    {
        n.opts <- if (func == "Column") 5 else 3
        for (ii in 1:n.opts)
        {
            filestem <- paste("stacked", tolower(func), dat, names(opts)[ii], sep="-")
            test_that(filestem, {
                
                stack.str <- "\"Stacked\", "
                if (ii %% 2 == 0)
                    stack.str <- "\"100% Stacked\", "
                cmd <- paste0("pp <- ", func, "(", dat, ", type = ", stack.str, opts[ii], ")")
                
                if (grepl("missing", filestem) && func == "Area")
                    expect_error(eval(parse(text=cmd)))
                else
                {
                    expect_error(suppressWarnings(eval(parse(text=cmd))), NA)
                    expect_true(TestWidget(pp, filestem))
                
                    #print(pp)
                    #readline(prompt=paste0(filestem, ": press [enter] to continue: "))
                    
                }
            })
        }
    }
}
