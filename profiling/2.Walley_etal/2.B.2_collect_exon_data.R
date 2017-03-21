### Jinliang Yang
### 03-20-2017
### Counting exon using kallisto

rtb <- read.delim("data/SraRunTable_walley_etal_2016.txt", header=TRUE)
sra <- data.frame(SRR=rtb$Run_s, sid=rtb$Sample_Name_s,pid=rtb$tissue_s,gid=rtb$genotype_s)


library("data.table")


col_tpm <- function(f){
  t1 <- fread(paste0(f[1], "/abundance.tsv"), data.table=FALSE)
  names(t1)[5] <- gsub(".*\\/", "", f[1])
  
  for(i in 2:length(f)){
    t2 <- fread(paste0(f[i], "/abundance.tsv"), data.table=FALSE)
    names(t2)[5] <- gsub(".*\\/", "", f[i])
    
    t1 <- merge(t1, t2[, c(1,5)], by="target_id")
    message(sprintf("####>>> [col_tpm] working on [%s] file ...", i))
  }
  return(t1)
}

######
f <- list.files(path="largedata/walley", pattern="", full.names = TRUE)
out <- col_tpm(f)

write.table(out, "largedata/tpm_9runs.csv", sep=",", row.names=FALSE, quote=FALSE)


out$geneid <- gsub(".exon.*", "", out$target_id)
out$geneid <- gsub("_E.*", "", out$geneid)


###>>> In this path: cd /home/jolyang/Documents/Github/ZeaGTEx
###>>> RUN: sbatch -p bigmemm --ntasks=1 --time=8:00:00 slurm-script/run_kquant_array.sh

