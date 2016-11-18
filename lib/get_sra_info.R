
checksra <- function(info=rs, Gb=100, cols=c("submission", "sample", "experiment")){
  
  info$bases <- as.numeric(info$bases)
  #info <- subset(info, bases > Gb*1000000)
  #pro <- length(unique(info$BioProject))
  #res <- info[, c("submission", "study", "sample", "experiment", "run","run_date","updated_date","bases",
  #                "run_alias", "platform", "study_title", "sample_alias","submission_center","submission_lab")]
  tab <- ddply(info, .(study), summarise,
               tot = round(sum(bases)/1000000000, 0))
  ures <- info[!duplicated(info$study), ]
  
  tab <- merge(tab, ures[, c("study", "updated_date", cols)], by="study")
  
  tab <- tab[order(tab$tot, decreasing = TRUE),]
  tab$year <- gsub("-.*", "", tab$updated_date)
  #tab <- ddply(info, su)
  message(sprintf("###>>> tot submission [ %s ] and [ %s ] > %s Gb", 
                  nrow(tab), nrow(subset(tab,tot > Gb) ), Gb))
  return(tab)
}


get_sra_info <- function(sra, tab, bycol="submission", which_info="study_title"){
  
  idx <- which(names(sra) == bycol)
  sub <- sra[!duplicated(sra[, idx]), ]
  sub <- sub[,c(bycol, which_info)]
  
  out <- merge(tab, sub, by=bycol)
  return(out)
}