### Jinliang Yang
### 01-30-2017
### Download run data


rtb <- read.delim("data/Liu_etal_2013_PNAS_sratable.txt", header=TRUE)
#c('submission','study','sample','experiment')
sum(rtb$MBases_l)

sra <- data.frame(SRR=rtb$Run_s,
                  sid=rtb$Sample_Name_s,
                  pid=rtb$tissue_s)

source("lib/set_slurm_arrayjob.R")
source("lib/run_ascp.R")
run_aspera(sra[2:10,], maxspeed="100m", outdir="/oasis/scratch/comet/$USER/temp_project/largeIO",
           arrayjobs="1-9", jobid="aspera", email="yangjl0930@gmail.com",
           runinfo=c(TRUE, "bigmemh", "1", "90"))
#'

tab <- out[order(out$tot, out$year, decreasing = TRUE),]
nrow(subset(tab, tot > 100 & submission_center != "JGI"))
nrow(subset(tab, tot > 10 & submission_center != "JGI"))

#info <- subset(info, submission_center != "JGI")
write.table(tab, "data/info_maize_2016.csv", sep=",", row.names=FALSE, quote=TRUE)






