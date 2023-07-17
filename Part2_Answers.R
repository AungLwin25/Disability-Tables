library(readxl)
Test_ghp3_2 <- read_excel("Test_ghp3_2.xls")
View(Test_ghp3_2)
Test_ghp3_2 -> Gh

names(Gh)
table(Gh$country)

library(tidyverse)

n_distinct(Gh$admin1)
n_distinct(Gh$admin2)

Gh %>%
  group_by(admin1) %>%
  summarise(dsCount = n_distinct(admin2)) -> Ds
Ds2 <- Ds[order(-Ds$dsCount),]-> Ds3
Ds3

Gh %>% filter(year>2017 & year<2023) -> Ghyr
head(Ghyr)
tail(Ghyr)

Ghyr <- Ghyr[order(Ghyr$year),] -> y2
write.csv(y2,"GhYear2018_2022.csv")

Ghyr %>% filter(is.na(vaccine_name)|is.na(target_define)| is.na(doses)| is.na(target_number)) -> ms
ms
# A tibble: 0 × 8
# ℹ 8 variables: country <chr>, year <dbl>, admin1 <chr>, admin2 <chr>,
#   vaccine_name <chr>, target_define <chr>, doses <dbl>, target_number <dbl>

#No missing value detected for the checked variables. OK!
Ghyr %>% filter(vaccine_name== "BCG" & !str_detect(target_define,"LIVE")) -> BCG_Denom_Prb
Ghyr %>% filter(vaccine_name!= "BCG" & !str_detect(target_define,"SURV")) -> OtherVac_Denom_Prb
Ghyr %>% filter(doses>target_number) -> incon_dose_target
dim(incon_dose_target)
# [1] 2806    8


Ghyr %>% group_by(admin1) %>% summarise(dose = sum(doses),
                                        target=sum(target_number))-> yr3

yr3 %>% mutate(coverage= dose/target) -> yr4

yr4[order(-yr4$coverage),] -> yr5
