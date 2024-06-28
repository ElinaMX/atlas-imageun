df <- read.csv("./data/media_FRA_specif_Eur_EU.csv")
list_mots <- head(df[order(df$chi2),"feature"], 10)
list_mots <- c(list_mots, tail(df[order(df$chi2),"feature"], 10))


library(tidyr)
colnames(df)
df_wide <- df |> 
  filter(feature %in% list_mots)

View(df_wide)
# write.csv(df_wide, "./data/extrait_pyramide_wide.csv")


dflong <- df |> 
  pivot_longer(cols = n_target:n_reference, 
               names_to = "deviation", 
               values_to = "count") |> 
  filter(feature %in% list_mots)

View(dflong)
list_mots
unique(dflong$feature)

# write.csv(dflong, "./data/extrait_pyramide_long.csv")
# "commission", "euro", "zone", "plus", "parlement", "accord", "france", "sortie", "banque", "banque_centrale", "centrale_européenne", "sanctions", "états-unis", "coupe", "monde", "continent", "grand", "champion", "vieux", "championne"