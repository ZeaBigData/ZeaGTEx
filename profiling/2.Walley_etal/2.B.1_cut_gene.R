### Jinliang Yang
### 8/11/2016
### Counting kmer frq for each genes

####### get gene id
geneid <- read.table("/home/jolyang/dbcenter/AGP/AGPv2/ZmB73_5b_FGS_info.txt", header=T)
geneid <- subset(geneid, is_canonical == "yes")


feature <- geneid[, c("chromosome", "transcript_start", "transcript_end", "gene_id")]
names(feature) <- c("chr", "start", "end", "geneid")
feature$chr <- gsub("chr", "", feature$chr)

feature <- subset(feature, chr %in% 1:10)

library("Biostrings")
#library("pseudoRef")
fa <- readDNAStringSet(filepath = "~/dbcenter/AGP/AGPv2/ZmB73_5a_WGS_exons.fasta.gz", format="fasta")










res <- kcount(fa, feature, kmers=1:7)
out <- t(res)
write.table(out, "largedata/kmer_count.csv", sep=",", quote=FALSE)


#### plotting
library(data.table)
out <- fread("largedata/kmer_count.csv", sep=",", header=FALSE)
h <- read.csv("largedata/kmer_count.csv", sep=",", nrow=5, header=TRUE)
out[, 1:10, with=FALSE]
out <- as.data.frame(out)
names(out) <- c("geneid", names(h))

tb <- data.frame(na=names(h), kmer=1)
tb$kmer <- nchar(as.character(tb$na))
## get mean count
mc <- apply(out[, -1], 2, mean)

par(mfrow=c(2,3))
hist(mc[which(tb$kmer == 2)], main="mean 2mer across genes", xlab="2mer")
hist(mc[which(tb$kmer == 3)], main="mean 3mer across genes", xlab="3mer")
hist(mc[which(tb$kmer == 4)], main="mean 4mer across genes", xlab="4mer")
hist(mc[which(tb$kmer == 5)], main="mean 5mer across genes", xlab="5mer")
hist(mc[which(tb$kmer == 6)], main="mean 6mer across genes", xlab="6mer")
hist(mc[which(tb$kmer == 7)], main="mean 7mer across genes", xlab="7mer")










