library(readxl)
DHIS2_data_Ghana_v3 <- read_excel("DHIS2_data_Ghana_v3.xlsx",
                                    +     sheet = "S1")
View(DHIS2_data_Ghana_v3)
DHIS2_data_Ghana_v3 -> S1

DHIS2_data_Ghana_v3 <- read_excel("DHIS2_data_Ghana_v3.xlsx",
                                  +     sheet = "S2")
View(DHIS2_data_Ghana_v3)
DHIS2_data_Ghana_v3 -> S2

DHIS2_data_Ghana_v3 <- read_excel("DHIS2_data_Ghana_v3.xlsx",
                                      sheet = "S3")
DHIS2_data_Ghana_v3 -> S3

S3[1:15660,] -> S3a

library(tidyverse)
rename(S1,District = `District name`) -> S1a

n_distinct(S1a$District)
#[1] 261
n_distinct(S2$District)
#[1] 261

table(S1a$Year)
#2017 2018 2019 2020 2021
#3132 3132 3132 3132 3132

table(S2$Year)
#2017 2018 2019 2020 2021
#3132 3132 3132 3132 3132

cbind(S1a,S2,S3a)-> db
write.csv(db,"Service_Database.csv")


