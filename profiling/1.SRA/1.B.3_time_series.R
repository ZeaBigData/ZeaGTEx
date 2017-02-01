### Jinliang Yang
### 01-30-2017
### Download run data


d <- read.csv("data/Liu_etal_2013_s1.csv", header=TRUE)

plot(1:13, y=d[, 2:14], type="l")
for(i in 1:nrow(d)){
  lines(1:13, y=d[i, 2:14])
}




#c('submission','study','sample','experiment')
sum(rtb$MBases_l)

sra <- data.frame(SRR=rtb$Run_s,
                  sid=rtb$Sample_Name_s,
                  pid=rtb$tissue_s)

source("lib/set_slurm_arrayjob.R")
source("lib/run_ascp.R")
run_aspera(sra[2:10,], maxspeed="100m", outdir="/oasis/scratch/comet/$USER/temp_project/largeIO",
           arrayjobs="1-9", jobid="aspera", email="yangjl0930@gmail.com",
           runinfo=c(FALSE, "compute", "1", "90"))







