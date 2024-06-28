library(sf)
library(mapsf)
iso

iso <- readRDS("./data/mapiso_Europe_All_students.RDS")
rocketPal <- mf_get_pal(n = nrow(iso), palette = "Rocket", alpha = 1, rev = T)
iso <- cbind(iso, rocketPal, survey = rep(x = "All students", nrow(iso)))
isoEur <- st_transform(iso, st_crs(4326))
isoEur
"#FDF5EBFF"
iso <- readRDS("./data/mapiso_Europe_French_students.RDS")
rocketPal <- mf_get_pal(n = nrow(iso), palette = "Rocket", alpha = 1, rev = T)
iso <- cbind(iso, rocketPal, survey = rep(x = "France Metropolitan", nrow(iso)))
isoFra <- st_transform(iso, st_crs(4326))
isoFra

iso <- readRDS("./data/mapiso_Europe_German_students.RDS")
rocketPal <- mf_get_pal(n = nrow(iso), palette = "Rocket", alpha = 1, rev = T)
iso <- cbind(iso, rocketPal, survey = rep(x = "Germany", nrow(iso)))
isoDEU <- st_transform(iso, st_crs(4326))
isoDEU

# divergent
iso <- readRDS("./data/mapiso_Europe_Dif_French_German_students.RDS")
rocketPal <- cols <- mf_get_pal(n = c(4, 2), pal = c("Purple-Orange", "BluGrn"))
iso <- cbind(iso, rocketPal, survey = rep(x = "France Germany difference", nrow(iso)))
isoDiff <- st_transform(iso, st_crs(4326))
isoDiff$rocketPal
"#5B3794" "#AA5FA5" "#E198B5" "#F8DCD9" "#F3F1E4" "#B3E7C5"

# Add carib et Ant
iso <- st_read("./data/W1C_isosAnt.GeoJSON")
rocketPal <- mf_get_pal(n = nrow(iso), palette = "Rocket", alpha = 1, rev = T)
iso_carib <- cbind(iso, rocketPal, survey = rep(x = "Caribbean", nrow(iso)))
iso_carib

iso <- st_read("./data/W1D_isosCarib.GeoJSON")
rocketPal <- mf_get_pal(n = nrow(iso), palette = "Rocket", alpha = 1, rev = T)
isoAnt <- cbind(iso, rocketPal, survey = rep(x = "Antilles", nrow(iso)))
isoAnt


isos <- rbind(isoEur, isoFra, isoDEU, isoAnt, iso_carib)

plot(st_geometry(isos))

st_write(isos, "./data/isos.GeoJSON", 
         layer_options = "RFC7946=YES",
         driver = "GeoJSON")
