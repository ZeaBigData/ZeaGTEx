#' \code{Run fastq-dump.}
#'
#' fastq-dump to dump SRA file.
#'
#' see more detail about fastq-dump with Aspera downloading:
#' \url{https://www.ncbi.nlm.nih.gov/books/NBK158900/}
#' 
#' @param df Input SRA files, [data.table, col: file]
#' @param filepath The absolute path of the SRA files.
#' @param single Single end or not. [Default=TRUE]
#' @param slurmsh File name of the output shell command.
#' @param rmsra Remove the original SRA file after dumpping.
#' @param email Your email address that farm will email to once the job was done/failed.
#' @param gzip GZIP the fastq files.
#' @param run  Parameters control the array job partition.
#' A vector of c(TRUE, "bigmemh", "8196", "1"): 1) run or not, 2) -p partition name, 3) --mem, adn 4) --ntasks.
#'
#' @return return a single shell script to run.
#'
#' @examples
#' ## run a single node job:
#' run_fq_dump(filepath="/group/jrigrp4/BS_teo20/WGBS",
#'             slurmsh="slurm-script/dump_WGBS.sh", rmsra=TRUE, email=NULL)
#'
#' ##  run array job:
#' run_fq_dump2(filepath="test", rmsra=TRUE, gzip=TRUE, email=NULL, run=c(TRUE, "bigmemh", "8196", "1"))
#'
#' @export
run_fq_dump <- function(df, filepath, single=TRUE,
                        rmsra=TRUE, gzip=TRUE, email=NULL,
                        runinfo=c(TRUE, "bigmemh", "1", "90")){
  
  #files <- list.files(path=filepath, pattern="sra$")
  dir.create("slurm-script", showWarnings = FALSE)
  for(i in 1:nrow(df)){
    
    shid <- paste0("slurm-script/run_dump_", i, ".sh")
    cmd1 <- paste0("cd ", filepath)
    cmd2 <- paste0("fastq-dump --split-spot --split-3 -A ", df$file[i])
    cmd <- c(cmd1, cmd2)
    if(rmsra){
      cmd3 <- paste0("rm ", df$file[i])
      cmd <- c(cmd, cmd3)
    }
    if(gzip){
      if(single){
        cmd4 <- paste0("gzip ", paste0(df$file[i], ".fastq"))
        cmd <- c(cmd, cmd4)
      }else{
        cmd4 <- paste0("gzip ", paste0(df$file[i], "_1.fastq"))
        cmd5 <- paste0("gzip ", paste0(df$file[i], "_2.fastq"))
        cmd <- c(cmd, cmd4, cmd5)
      }
      
    }
    cat(cmd, file=shid, sep="\n", append=FALSE)
  }
  
  shcode <- paste("sh slurm-script/run_dump_$SLURM_ARRAY_TASK_ID.sh", sep="\n")
  myshid <- "slurm-script/run_fq-dump_array.sh"
  
  set_array_job(shid=myshid,
                shcode=shcode, arrayjobs=paste("1", nrow(df), sep="-"),
                wd=NULL, jobid="dump", email=email, runinfo = runinfo)
}
