### Jinliang Yang
### 01-30-2017
### Download run data


files <- list.files(path="~/dbcenter/zeabigdata", pattern="sra$")
#c('submission','study','sample','experiment')
df <- data.frame(file=files, id=1:length(files))



source("lib/set_slurm_arrayjob.R")
source("lib/run_fq_dump.R")

run_fq_dump(df, filepath="~/dbcenter/zeabigdata", single=TRUE,
            rmsra=TRUE, gzip=TRUE, email="yangjl0930@gmail.com",
            runinfo=c(FALSE, "serial", "1", "12:00:00"))

###>>> In this path: cd /home/jolyang/Documents/Github/ZeaGTEx
###>>> RUN: sbatch -p serial --ntasks=1 --time=12:00:00 slurm-script/run_fq-dump_array.sh

### build kallisto idex
# kallisto index -i Zea_mays.AGPv4.cdna.all.kallisto.idx Zea_mays.AGPv4.cdna.all.fa.gz

# kallisto quant -i ~/dbcenter/AGP/AGPv4/Zea_mays.AGPv4.cdna.all.kallisto.idx --plaintext -o . -b 100 SRR611806.sra_1.fastq SRR611806.sra_2.fastq > test.txt


