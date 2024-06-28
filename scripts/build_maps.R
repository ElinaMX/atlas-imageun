library(sf)
library(dplyr)
library(mapiso)
library(mapsf)
library(colorspace)
library(classInt)
library(leaflet)

library(tictoc)

# passer de 1+e05 à 100000
options(scipen = 10)

world50 <- st_read("data/raw/world_basemap_50.gpkg",
                   layer = "world_50")

gridCenters <- readRDS("data/raw/grid_area_100000.rds")



geometries <- st_read("data/clean/geometries.gpkg", "geometries")
surfey <- readRDS("data/clean/survey_anon_short_280524.rds")
surfey$A0405_cad_univer_lab_country
BDG <- merge(geometries, 
             surfey[,c("X0001_met_respID_aut", "A0405_cad_univer_lab_country")],
             "X0001_met_respID_aut")
unique(BDG$A0405_cad_univer_lab_country)
BDG_ant <- BDG[BDG$A0405_cad_univer_lab_country %in% "France Antilles",]
BDG_ant <- BDG_ant[BDG_ant$geom_carto == TRUE, ]

"West Indies"

BDG_sub <- BDG_ant[BDG_ant$E1903_map_rgname_parent1_en %in% "West Indies",]

# Calcul des intersections grille - polygones
result_intersection <- st_intersects(x = gridCenters, 
                                     y = BDG_sub, 
                                     sparse = TRUE) 

# Ajout du nombre d'intersection détectés dans l'attribut "count"
gridCenters$count <- lengths(result_intersection) 
gridCenters$pct <- gridCenters$count / nrow(BDG_sub) * 100
gridCenters$pct[gridCenters$pct == 0] <- NA

#------------------------------------------------------------------------------#
# PASSAGE EN ISOPOLYG
#------------------------------------------------------------------------------#
library(mapsf)

# Discrétisation par amplitude égales
discr <- mf_get_breaks(gridCenters$pct, breaks = "equal", nbreaks = 10)


discr <- seq(round(min(!is.na(gridCenters$pct)), -1), 100, 10)
# Bornes des classes (amplitude égale) :
discr

library(mapiso)

iso_surface <- mapiso(x = gridCenters,
                      var = "pct", 
                      breaks = discr)

mf_map(iso_surface)

#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# CARTO 
#------------------------------------------------------------------------------#




# isosAnt <- st_read("data/isos.gpkg", layer= "isosAnt")
isosAnt <- iso_surface
isosAnt <- st_transform(isosAnt, st_crs(4326))
rocketPal <- mf_get_pal(n = length(discr)-1, palette = "Rocket", alpha = 1, rev = T)

st_write(isosAnt, "data/clean/atlas/isosAnt.GeoJSON", 
         layer_options = "RFC7946=YES",
         driver = "GeoJSON")
rocketPal
rocket = ["#FDF5EBFF", "#F2BE91FF",
          "#EE8F5CFF", "#E85D48FF",
          "#D6245AFF", "#AF0065FF",
          "#870061FF", "#5F0052FF",
          "#370439FF", "#070707FF"]

  d > Levels[8] ? '#070707FF' :
  d > Levels[7] ? '#370439FF' :
  d > Levels[6] ? '#5F0052FF' :
  d > Levels[5]  ? '#870061FF' :
  d > Levels[4]  ? '#AF0065FF' :
  d > Levels[3]  ? '#D6245AFF' :
  d > Levels[2]  ? '#E85D48FF' :
  d > Levels[1]   ? '#EE8F5CFF' :
  d > Levels[0]   ? '#F2BE91FF' :
  '#FDF5EBFF';


# Construire la carte 
leaflet(isosAnt)  |> 
  addTiles(attribution = "ANR-DFG IMAGEUN (2020-2024) - Students Database") |> 
  addPolygons(
    fillColor = rocketPal,
    weight = 0.2,
    color = "#444",
    dashArray = "",
    fillOpacity = 0.6,
    highlightOptions = highlightOptions(
      weight = 0.5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = paste0(isosAnt$isomin, " to ", isosAnt$isomax)) |>
  addLegend(position = "bottomright", 
            values = isosAnt$isomax,
            colors = rocketPal, 
            labels = isosAnt$isomax, 
            title = "Pct of geometries")
