### Jinliang Yang
### Dec 17th, 2016
### SRA query


library(tidyr)
library(plyr)
source("lib/get_sra_info.R")

rs <- read.delim("data/sra_maize_11-17-2016.txt", header=TRUE)
#c('submission','study','sample','experiment')

out <- checksra(info=rs, Gb=100)
###>>> tot submission [ 577 ] and [ 91 ] > 100 Gb
###>>> tot submission [ 837 ] and [ 102 ] > 100 Gb

tab <- out[order(out$year, out$tot, decreasing = TRUE),]
nrow(subset(tab, tot > 100 & submission_center != "JGI"))
nrow(subset(tab, tot > 10 & submission_center != "JGI"))



names(rs)
info <- get_sra_info(sra=rs, tab, bycol="submission", 
                     which_info=c("submission_lab","submission_date",
                                  "study_title", "study_abstract", "study_description" ) )
info <- info[order(info$year, info$tot, decreasing = TRUE),]
nrow(subset(info, tot > 100 & submission_center != "JGI"))
nrow(subset(tab, tot > 10 & submission_center != "JGI"))

info <- subset(info, submission_center != "JGI")
write.table(info, "data/info_maize_2016.csv", sep=",", row.names=FALSE, quote=TRUE)

