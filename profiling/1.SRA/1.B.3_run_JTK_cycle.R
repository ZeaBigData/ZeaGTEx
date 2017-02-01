
source("largedata/JTKversion3/JTK_CYCLEv3.1.R")

project <- "Example1"

options(stringsAsFactors=FALSE)
annot <- read.delim("largedata/JTKversion3/Example1_annot.txt")
data <- read.delim("largedata/JTKversion3/Example1_data.txt")
data <- read.csv("data/Liu_etal_2013_s1.csv")

rownames(data) <- data[,1]
data <- data[,2:14]
jtkdist(ncol(data))

jtkdist(13, 1)       # 13 total time points, 2 replicates per time point

periods <- 2:5       # looking for rhythms between 12-30 hours (i.e. between 5 and 7 time points per cycle).
jtk.init(periods,6)   # 4 is the number of hours between time points

cat("JTK analysis started on",date(),"\n")
flush.console()

st <- system.time({
  res <- apply(data,1,function(z) {
    jtkx(z)
    c(JTK.ADJP,JTK.PERIOD,JTK.LAG,JTK.AMP)
  })
  res <- as.data.frame(t(res))
  bhq <- p.adjust(unlist(res[,1]),"BH")
  res <- cbind(bhq,res)
  colnames(res) <- c("BH.Q","ADJ.P","PER","LAG","AMP")
  results <- cbind(res,data)
  results <- results[order(res$ADJ.P,-res$AMP),]
})
print(st)

save(results,file=paste("JTK",project,"rda",sep="."))
write.table(results,file=paste("JTK",project,"txt",sep="."),row.names=F,col.names=T,quote=F,sep="\t")


source("~/Documents/Github/zmSNPtools/Rcodes/rescale.R")
myrescale <- function(x){
  return(rescale(x, newrange=c(0,1)))
}

out <- apply(r[, -1:-5], 1, myrescale)
t <- t(out)
t <- t[order(t[,1]),]
nba_heatmap <- heatmap(t, Rowv=NA, Colv=NA, col = cm.colors(256), scale="column", margins=c(5,10))


plot(0:12*6, y=t[1, 1:ncol(t)], type="l")
abline(v=24, col="grey")
abline(v=48, col="grey")
#r <- subset(results, ADJ.P < 0.05)
for(i in 1:nrow(t)){
  lines(0:12*6, y=t[i, 1:ncol(t)])
}
