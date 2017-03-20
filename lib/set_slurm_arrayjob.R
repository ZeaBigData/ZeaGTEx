#' \code{Set up array job on farm}
#'
#' Farm is a computer cluster running slurm system.
#' Note, bigmem mem=8000 per cpu, hi med low mem=25000 per cpu, serial mem=1500 per cpu.
#'
#' @param shid Relative or absolute path and file name of your shell code, i.e. CL_test.sh.
#' @param shcode The commands inside your sh file.
#' @param arrayjobs A character specify the number of array you try to run, i.e. 1-100.
#' @param wd Working directory, default=NULL. It will use your current directory.
#' @param jobid The job name show up in your sq NAME column.
#' @param email Your email address that farm will email to once the job was done or failed.
#' @param runinfo  Parameters specify the array job partition information.
#' A vector of c(TRUE, "bigmemh", "1"): 1) run or not, 2) -p partition name, and 3) --cpus.
#'
#' @return return a shell file.
#'
#' @examples
#' for(i in 1:10){
#'     shid <- paste0("slurm-script/run_", i, ".sh")
#'     command <- paste0("bedtools getfasta -name -tab -fi roast.chrom.", i, ".msa.in")
#'     cat(command, file=shid, sep="\n", append=FALSE)
#' }
#' shcode <- paste("module load bismark/0.14.3", "sh slurm-script/run_$SLURM_ARRAY_TASK_ID.sh", sep="\n")
#'
#' set_array_job(shid="slurm-script/run.sh", shcode=shcode,
#'               arrayjobs="1-10", wd=NULL, jobid="myjob", email=NULL,
#'               run = c(TRUE, "bigmemh", "1"))
#'
#' @export
set_array_job <- function(
  shid="largedata/GenSel/CL_test.sh", shcode="sh largedata/myscript.sh",
  arrayjobs="1-700", wd=NULL, jobid="myjob", email=NULL,
  runinfo=c(TRUE, "bigmemh", "1", "8:00:00")  ){

    #message(sprintf("###>>> cp from Introgression, tailored for pvpDiallel"))
    ##### setup working directory
    if(is.null(wd)){
       wd <- getwd()
    }
    dir.create("slurm-log", showWarnings = FALSE)
    sbath <- paste0(wd, "/slurm-log/")
    sbatho <- paste0(sbath, "testout-%j.txt")
    sbathe <- paste0(sbath, "err-%j.txt")

    #### parameters pass to slurm script
    cat(paste("#!/bin/bash -l"),
        #-D sets your project directory.
        #-o sets where standard output (of your batch script) goes.
        #-e sets where standard error (of your batch script) goes.
        #-J sets the job name.
        paste("#SBATCH -D", wd, sep=" "),
        paste("#SBATCH -o", sbatho, sep=" "),
        paste("#SBATCH -e", sbathe, sep=" "),
        paste("#SBATCH -J", jobid, sep=" "),
        paste0("#SBATCH --array=", arrayjobs),
        paste0("#SBATCH --mail-user=", email),
        paste("#SBATCH --mail-type=END"),
        paste("#SBATCH --mail-type=FAIL #email if fails"),

        "set -e",
        "set -u",
        "",
        #"module load gmap/2014-05-15",
        file=shid, sep="\n", append=FALSE);

    #### the sbatch code
    #runinfo <- get_runinfo(runinfo)
    runcode <- paste0("sbatch -p ", runinfo[2], " --ntasks=", runinfo[3], " --time=", runinfo[4], " ", shid)

    #### attach some sh scripts
    cat(shcode, file=shid, sep="\n", append=TRUE)
    if(runinfo[1]){
      message(runcode)
      system(runcode)
    }else{
      message(paste("###>>> In this path: cd ", wd, sep=""), "\n",
              paste("###>>> RUN:", runcode))
    }
}


