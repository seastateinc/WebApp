#global.R

A80 <- readRDS("data/A80.rds")
dateRange  <- range(ymd(A80$HaulDate))
