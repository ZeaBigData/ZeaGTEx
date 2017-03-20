### Jinliang Yang
### 03-20-2017
### Counting exon using kallisto

### build kallisto idex
# kallisto index -i ZmB73_5a_WGS_exons.kallisto.idx ZmB73_5a_WGS_exons.fasta.gz
# kallisto quant -i ~/dbcenter/AGP/AGPv2/ZmB73_5a_WGS_exons.kallisto.idx --plaintext -o . --single -l 200 -s 20 SRR957415.sra.fastq SRR957416.sra.fastq > test.txt

source("lib/set_slurm_arrayjob.R")
source("lib/run_kallisto.R")


files <- list.files(path="~/dbcenter/zeabigdata", pattern="fastq$", full.names = TRUE)
#c('submission','study','sample','experiment')
df <- data.frame(fq=files, outdir="largedata/walley", outfile= paste0(gsub(".*\\/|sra.fastq", "", files), "txt"))


run_kallisto(df, single=TRUE, l=200, s=20,
             idx="~/dbcenter/AGP/AGPv2/ZmB73_5a_WGS_exons.kallisto.idx",
             email="yangjl0930@gmail.com",
             jobid="run_kquant", runinfo=c(FALSE, "serial", "1", "8:00:00"))





