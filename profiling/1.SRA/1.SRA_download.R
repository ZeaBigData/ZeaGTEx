### Jinliang Yang
### Dec 17th, 2016
### SRA query

# https://www.bioconductor.org/packages/release/bioc/vignettes/SRAdb/inst/doc/SRAdb.pdf
# search ["maize" OR "zea mays"]

source("http://bioconductor.org/biocLite.R")
biocLite("SRAdb")

library(SRAdb)

# The SRAdb R package is a set of functions meant to
# interact with a SQLite database, so it is necessary to download
# the SQLite database file before proceeding. 
sqlfile = getSRAdbFile(destdir="largedata")
sfile <- "largedata/SRAmetadb.sqlite"
file.info("largedata/SRAmetadb.sqlite")

sra_con = dbConnect(SQLite(), sfile)

# list all the tables in teh SQLite database
sra_tables <- dbListTables(sra_con)
# There is also the dbListFields function that can list database fields associated with a table.
dbListFields(sra_con,"experiment")

# Sometimes it is useful to get the actual SQL schema associated with a table. Here, we
# get the table schema for the study table:
dbGetQuery(sra_con, 'PRAGMA TABLE_INFO(study)')

# The table ”col desc” contains information of filed name, type, descritption and default values:
colDesc <- colDescriptions(sra_con=sra_con)


###### ----------- ######
rs <- getSRA(search_terms='maize OR "zea mays" ',
             out_types=c('sra','submission','study','experiment','sample','run'), 
             sra_con, acc_only=FALSE)

dbListFields(sra_con,"sra")
dbListFields(sra_con,"submission")

write.table(rs, "data/sra_maize_11-17-2016.txt", sep="\t", row.names=FALSE, quote=FALSE)



