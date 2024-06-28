library(sf)


BDG <- st_read("./data/BDG_4326_carto.GeoJSON")
head(BDG)
BDG_ant <- BDG[BDG$country %in% "France Antilles",]

st_write(BDG_ant, "./data/W1B_2.GeoJSON", 
         layer_options = "RFC7946=YES",
         driver = "GeoJSON")
