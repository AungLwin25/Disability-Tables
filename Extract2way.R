BaseExtract <- function(Name,StartYear) {

  # Load libraries
  library(readxl)
  library(miceadds)
  library(tidyverse)
  library(sjmisc)
  library(stringr)
  library(reshape2)

  # Read Census data
  d0 <- readxl::read_excel(file.path(directory = "C:/Users/aklwin/OneDrive/R programming/Github/Disability-Tables", paste0(Name,".xlsx")))

  # Assign the starting age
  y0 <-StartYear

  # Wrangle data
  #1 name age series
  d0 [-c(1:12),-1] -> d1
  colnames(d1) <- paste0("year",d1[1,])
  d1[-1,] -> d2
  rename(d2,Edn=yearNA) -> d3

  #2 identify last row
  which(d3$Edn == "Total") -> x

  #3 drop rows after "Total"
  d3 %>% filter(row_number()<=x) -> d4

  # resahpe data
  d4 %>% filter(Edn== "Total") -> s1
  melt(s1,id="Edn") -> s2
  s2 %>% select(-1)-> s2a

  write.csv(s2a,paste0(Name,".csv"))
  s2a-> tb
}

#r
# Totals based on "school attendance" population
BaseExtract("BasePop1and2Sch",5)
BaseExtract("BasePop3and4Sch",5)

# Totals based on "highest grade completed" population
BaseExtract("BasePop1and2Grd",5)
BaseExtract("BasePop3and4Grd",5)

# School attendance totals
BaseExtract("AttSexAgeGt2",5)
BaseExtract("AttSexAgelt3",5)

# Highest grade achieved totals
BaseExtract("GrdSexAgeGt2_NoEdu",5)
