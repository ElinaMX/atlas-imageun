// ---------------------------------------------------------------------------
//                        INPUTS
// ---------------------------------------------------------------------------

viewof select_W1A_2 = Inputs.select(["All", "Germany", "France Metropolitan", "France Antilles", "Ireland", "Turkey", "Tunisia"], {label: "Survey sample"})

viewof region_W1A_2 = Inputs.select(new Map([["All",'All'],["Europe","europe"],["Western Europe","europe_ouest"],
                ["Central Europe","europe_centr"],
                ["European Union","union_europ"],
                ["Africa","africa"],
                ["Northern Africa","africa_nord"],
                ["America","america"],
                ["Central America","america_ctr"],
                ["Asia/Eurasia","asia"],
                ["Mediterranean","medit"],
                ["Mid & Near East","mideast"],
                ["Carribean","carrib"],
                ["Antilles","antil"],
                ["The West/Ocident","western"]
                ]), {label: "Name of macroregion contains ..."})

// ---------------------------------------------------------------------------
//                        MAP
// ---------------------------------------------------------------------------

map_W1A_2 = {
  // Set highlight
function highlightFeature(e) {
    var layer = e.target;
    layer.setStyle({
        weight: 1,
        color: '#ba66a9',
        dashArray: '',
        fillOpacity: 0.5    
    });
}

  // Reset Highlight
  function resetHighlight(e) {
    layer.resetStyle(e.target);
}

  // OnEach featur
function onEachFeature(feature, layer) {
    layer.bindPopup(function (Layer) {
    return "<b>Country : </b>" + Layer.feature.properties.country + "<br>" +
      "<b>Sex : </b>" + Layer.feature.properties.sex + "<br>" +
      "<b>Fields of study : </b>" + Layer.feature.properties.field + "<br>" +
      "<b>Opinion about EU : </b>" + Layer.feature.properties.opiEU + "<br>" +
      "<b>Macro region : </b>" + Layer.feature.properties.macro + "<br>" +
      Layer.feature.properties.X0001_met_respID_aut + ' - "' + Layer.feature.properties.ID_geom + '" <br>';
  })
    layer.on({
        mouseover: highlightFeature,
        mouseout: resetHighlight,
    });
}

  // MAP
const container = yield htl.html`<div style="height: 50vh; width: 50vh">`;
const map = L.map(container);
const layer = L.geoJSON(macroreg_filtered_W1A_2, {
onEachFeature: onEachFeature,
  style: {
    opacity: opacity_W1A_2 + 0.1,
    fillOpacity: opacity_W1A_2,
    color: "#FFBC50",
    weight: 0.5}
  }).addTo(map);

// fit map to geom bounds  
map.fitBounds(layer.getBounds(), {maxZoom: 15});

// Tile Layer  
L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
    {attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
      subdomains: "abcd",
      maxZoom: 20
    }).addTo(map);
}


// ---------------------------------------------------------------------------
//                        TABLE
// ---------------------------------------------------------------------------



// ---------------------------------------------------------------------------
//                        DATA
// ---------------------------------------------------------------------------

macroreg_students_W1A_2 = FileAttachment("../data/W1A_BDG_macroreg.GeoJSON").json()

macroreg_W1A_2 = geo_W1A_2.simplify(macroreg_students_W1A_2, {k:0.25})

macroreg_sorted_W1A_2 = geo_W1A_2.featurecollection(macroreg_W1A_2.features.sort((a, b) => d3.descending(a.properties.area_3857, b.properties.area_3857)))

macroreg_filtered_W1A_2 = {
  let filtered =  region_W1A_2 == "All" ? macroreg_W1A_2 : geo_W1A_2.filter(macroreg_sorted_W1A_2, (d) => d[region_W1A_2] == 1)
  filtered = select_W1A_2 == "All" ? filtered : geo_W1A_2.filter(filtered, (d) => d.country == select_W1A_2)
  return geo_W1A_2.rewind(filtered)
}

opacity_W1A_2 = {let opacity
  if(macroreg_filtered.features.length > 50) { 
    return opacity = 0
  } else { 
    return opacity = 0.06
  }
}

// ---------------------------------------------------------------------------
//                        LIBS
// ---------------------------------------------------------------------------

geo_W1A_2 = require("geotoolbox@2.0.3")