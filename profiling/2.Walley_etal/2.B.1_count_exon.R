### Jinliang Yang
### 03-20-2017
### Counting exon using kallisto

### build kallisto idex
# kallisto index -i ZmB73_5a_WGS_exons.kallisto.idx ZmB73_5a_WGS_exons.fasta.gz
# kallisto quant -i ~/dbcenter/AGP/AGPv2/ZmB73_5a_WGS_exons.kallisto.idx --plaintext -o . --single -l 200 -s 20 SRR957415.sra.fastq SRR957416.sra.fastq > test.txt

source("lib/set_slurm_arrayjob.R")
source("lib/run_kallisto.R")


files <- list.files(path="~/dbcenter/zeabigdata", pattern="fastq.gz$", full.names = TRUE)
#c('submission','study','sample','experiment')
df <- data.frame(fq=files, outdir= paste0("largedata/walley/", gsub(".*\\/|.sra.fastq.gz", "", files)))
df$outdir <- as.character(df$outdir)
for(i in 1:nrow(df)) dir.create(df$outdir[i], showWarnings = FALSE)


run_kallisto(df, single=TRUE, l=200, s=20,
             idx="~/dbcenter/AGP/AGPv2/ZmB73_5a_WGS_exons.kallisto.idx",
             email="yangjl0930@gmail.com",
             jobid="run_kquant", runinfo=c(FALSE, "bigmemm", "1", "8:00:00"))

###>>> In this path: cd /home/jolyang/Documents/Github/ZeaGTEx
###>>> RUN: sbatch -p bigmemm --ntasks=1 --time=8:00:00 slurm-script/run_kquant_array.sh


