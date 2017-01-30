### Jinliang Yang
### 01-30-2017
### Download run data


rtb <- read.delim("data/Liu_etal_2013_PNAS_sratable.txt", header=TRUE)
#c('submission','study','sample','experiment')
sum(rtb$MBases_l)

sra <- data.frame(SRR=rtb$Run_s,
                  sid=rtb$Sample_Name_s,
                  pid=rtb$tissue_s)

run_aspera(sra[1:2,], maxspeed="100m", outdir=".", arrayjobs="1-2", jobid="aspera", email=NULL)
#'

tab <- out[order(out$tot, out$year, decreasing = TRUE),]
nrow(subset(tab, tot > 100 & submission_center != "JGI"))
nrow(subset(tab, tot > 10 & submission_center != "JGI"))

#info <- subset(info, submission_center != "JGI")
write.table(tab, "data/info_maize_2016.csv", sep=",", row.names=FALSE, quote=TRUE)






