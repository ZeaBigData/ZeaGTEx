### Jinliang Yang
### Dec 17th, 2016
### SRA query


library(tidyr)
library(plyr)
source("lib/get_sra_info.R")

rs <- read.delim("data/sra_maize_11-17-2016.txt", header=TRUE)
#c('submission','study','sample','experiment')

out <- checksra(info=rs, Gb=100, 
                cols=c("submission_center", "submission_lab",
                       "platform", "instrument_model", "platform_parameters",
                       "study_title","study_url_link","study_alias",
                       "submission_date", "study_abstract", "study_description"))
###>>> tot submission [ 461 ] and [ 95 ] > 100 Gb

tab <- out[order(out$tot, out$year, decreasing = TRUE),]
nrow(subset(tab, tot > 100 & submission_center != "JGI"))
nrow(subset(tab, tot > 10 & submission_center != "JGI"))

#info <- subset(info, submission_center != "JGI")
write.table(tab, "data/info_maize_2016.csv", sep=",", row.names=FALSE, quote=TRUE)






