#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# PACKAGES
library(dplyr)


#------------------------------------------------------------------------------#
#--------------------------- DATA TUNISIA--------------------------------------#
#------------------------------------------------------------------------------#
# tableau 1

region <- c("Tunisia", "Green Tunisia", "North Africa", "Mediterranean", "Tunis", 
         "my country", "Africa", "Maghreb", "France", "Turkey", "Total")
n <- c(30,16,10,9,6,5,3,3,1,1,84)
pct <- c(36,19,12,11,7,6,4,4,1,1,100)
tabReg <- data.frame(region, n, pct)

saveRDS(object = tabReg, file = "data/tunisia/tabReg_1_1")
View(tabReg)

wcdStReg <- readRDS("data/data_for_wordcloud_students_regions.RDS")
View(wcdStReg)
table()
regStu <- readRDS("data/reg_students_wordcloud.RDS")
View(regStu)


tabReg2 <- wcdStReg |> 
  filter(place %in% "Tunisia") |>
  group_by(word) |> 
  summarise(n = sum(observed)) |> 
  filter(n != 0) |> 
  mutate(pct = n/sum(n)*100)

tot <- summarise(tabReg2,
                      across(where(is.character), ~"Total"),
                      across(where(is.numeric), sum))

tabReg2 <- bind_rows(tabReg2, tot) |> 
  mutate(pct = round(pct, 0))
