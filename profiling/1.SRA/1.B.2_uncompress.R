### Jinliang Yang
### 01-30-2017
### Download run data


files <- list.files(path="/oasis/scratch/comet/jyang21/temp_project/largeIO", pattern="sra$")
#c('submission','study','sample','experiment')
df <- data.frame(file=files, id=1:length(files))



source("lib/set_slurm_arrayjob.R")
source("lib/run_fq_dump.R")

run_fq_dump(df, filepath="/oasis/scratch/comet/jyang21/temp_project/largeIO",
            rmsra=TRUE, gzip=TRUE, email="yangjl0930@gmail.com",
            runinfo=c(FALSE, "bigmemh", "1", "90"))



### build kallisto idex
# kallisto index -i Zea_mays.AGPv4.cdna.all.kallisto.idx Zea_mays.AGPv4.cdna.all.fa.gz

# kallisto quant -i ~/dbcenter/AGP/AGPv4/Zea_mays.AGPv4.cdna.all.kallisto.idx --plaintext -o . -b 100 SRR611806.sra_1.fastq SRR611806.sra_2.fastq > test.txt

