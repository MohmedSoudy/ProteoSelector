library(dplyr)
library(tidyverse)
#library(readxl)
#Used for getting arguments from user
args = commandArgs(trailingOnly=TRUE)
MatchedList <- as.array(as.numeric(strsplit(args[2], ',')[[1]]))
colIndex <- c(2,MatchedList)
ColHeaders <- NULL
AllSubReportContent <- NULL
ReportContent <- NULL
i <- FALSE
for (subdir in list.dirs(args[1], full.names = TRUE,recursive=FALSE)){
  #ReportContent <- NULL
  for(file in list.files(subdir)){
    ReportsPath <<- paste0(subdir , '\\' , file)
    ColHeaders <<- c(ColHeaders , file)
    #if (as.numeric(args[2]) == 0)
      ReportContent <<- read.csv(ReportsPath)
    #else
     # ReportContent <<- read.csv(ReportsPath)
    
    DupliactedIndecies <<- which(duplicated(ReportContent[,2]))
    if (is.na(DupliactedIndecies[1]))
      DistincitReportContent <<- ReportContent
    else
      DistincitReportContent <<- ReportContent[-DupliactedIndecies,]
    ReportContent <<- DistincitReportContent
    
    SelectedIndecies <<- ReportContent[,colIndex]
    Selectednames <- colnames(ReportContent)[colIndex]
    Names <- rep(file , length(MatchedList))
    Names <- paste0(Selectednames[2:length(Selectednames)] , Names)
    colnames(SelectedIndecies) <- c("Main Acessions",Names)
    UniqueColname <<- colnames(SelectedIndecies)[1]
    if (!i)
      AllSubReportContent <<- SelectedIndecies
    else
      AllSubReportContent <<- full_join(AllSubReportContent, SelectedIndecies, by=UniqueColname)
    i <<- TRUE
  }
  "Apply processing on OutputData"
  OutputPath <- paste0(subdir , '\\' , paste0(basename(subdir),'.csv'))
  write.csv(AllSubReportContent, OutputPath)
  ReportContent <<- NULL
  AllSubReportContent <<- NULL
  ColHeaders <<- NULL
  i <<- FALSE
}
