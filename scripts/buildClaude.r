---
output: html_document
editor_options: 
  chunk_output_type: console
---

  
library(dplyr)
library(sf)
library(mapview)
library(reshape2)
library(knitr)
st_layers(dsn = "../data/geometries.gpkg")

geometries <- st_read(dsn = "../data/geometries.gpkg", 
                    layer = "geometries") 



survey_anon <- readRDS("../data/survey_anon.rds")




### Jointure avec quelques caractéristiques des étudiants


don<-survey_anon %>% select(X0001_met_respID_aut,
                            country = A0405_cad_univer_lab_country,
                            field = A0406_cad_fields_lab_en,
                            sex = A0508_cad_gender_lab_en,
                            opiEU = H3102_eur_images_lab_en)
geom<-merge(geometries,don, by="X0001_met_respID_aut")


### Selection et recodage des macro-regions


regio <- geom %>% filter(E1903_map_rgname_scale=="macroregion")
regio$macro<-regio$E1903_map_rgname_tags
x<-table(regio$macro)
#x[order(-x)]
macro<-regio$macro
regio$macro2 <-case_when(macro=="CO_EUR" ~ "Europe",
                         macro=="CO_EUR_west" ~ "Europe West",
                         macro=="CO_EUR_centr" ~ "Europe Central",
                         macro=="OR_EU" ~ "European Union",
                         macro=="CO_EUR OR_EU" ~ "European Union",               
                         macro=="SE_antil_small" ~ "Carribean",
                         macro=="SE_antil" ~ "Carribean",
                         macro=="SE_carai" ~ "Carribean",
                         macro=="SE_antil_great" ~ "Carribean",
                         macro=="SE_antil ST_FRA_GUF" ~ "Carribean",
                         macro=="SE_carai SE_antil " ~ "Carribean",     
                         macro=="SE_medit" ~ "Mediterranean",
                         macro=="CO_EUR SE_medit" ~ "Mediterranean",
                         macro=="CU_Occident" ~ "The Western",
                         macro=="LA_east_middle" ~"Middle East",
                         macro=="CO_AFR_north" ~"Africa North",
                         macro=="CO_AFR"  ~ "Africa*",
                         macro=="CO_ERA" ~"Eurasia",
                         macro=="CO_EUR CO_ASIA" ~"Eurasia",                        
                         macro=="CO_AMR_centr" ~"America*",
                         macro=="CO_AMR_south" ~"America*",
                         macro=="XX_America" ~"America*",                      
                         macro=="LA_maghr" ~ "Africa North",
                         macro=="CO_hemis_north" ~ "The Western",
                         macro=="CO_EUR_north" ~ "Europe North",
                         macro=="CO_ASI" ~ "Asia*",
                         macro=="CO_ASI_east" ~ "Asia*",
                         macro=="CO_ASI_centr" ~ "Asia*",                        
                        TRUE ~ "Other"
                        )

str(regio)
regio <- st_transform(regio, 3857)


# st_write(obj = regio, 
#          dsn = "geomWhEU.geojson",
#             layer_options = "RFC7946=YES"
# )

