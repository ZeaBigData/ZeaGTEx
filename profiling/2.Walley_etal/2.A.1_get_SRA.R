### Jinliang Yang
### 03-20-2017
### download Walley et al., 2016 data

rtb <- read.delim("data/SraRunTable_walley_etal_2016.txt", header=TRUE)
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



