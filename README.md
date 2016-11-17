## Architecture about this Repo

To guide the visitors having a better sense about the project, here we briefly introduce the specific purposes of the directories. 
The layout of directories is based on the idea from [ProjectTemplate](http://projecttemplate.net/architecture.html). 

1. **cache**: Here we store intermediate data sets that are generated during preprocessing steps.
2. **data**: Here we store our raw data of small size. 
Data of large size, i.e. > 100M, store in a `largedata` folder that has been ignored using `.gitignore`.
3. **doc**: Documentation codes (i.e. Rmd files) for generating the figures.
4. **graphs**: Graphs produced during the analysis.
5. **lib**: Some functions used within this project.
6. **munge**: Here we store some preprocessing or data munging codes.
7. **profilling**: Main scripts for the project. It contains some sub-directories.

8. **TODO.md**: A todo list.
