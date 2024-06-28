// ---------------------------------------------------------------------------
  //                        INPUTS
// ---------------------------------------------------------------------------
  /*viewof select_W1B_2 = Inputs.select(["All", "Germany", "France Metropolitan", "France Antilles", "Ireland", "Turkey", "Tunisia"], {label: "Survey sample", value: "France Antilles"})
  */
  select_W1B_2 = "France Antilles"
  viewof stu_sel_W1B_2 = Inputs.text({label: "Student's ID", placeholder: "882osw6mv496", value: respListUnique_W1B_2[0]})
  
  viewof nextResp_W1B_2 = Inputs.button([
    ["Répondant précedent", value => value == 0 ? respListUnique_W1B_2.length- 1: value - 1],
    ["Répondant suivant", value => value >= respListUnique_W1B_2.length-1 ? 0 : value + 1],
  ], {value: respListUnique_W1B_2.findIndex(d => d === stu_sel_W1B_2), label: ""})
  
  
  // ---------------------------------------------------------------------------
    //                        MAP
  // ---------------------------------------------------------------------------
    
    
    map_W1B_2 = {
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
          return "<b><i>Region drawn : </b></i>" + 
            Layer.feature.properties.ID_geom + "<br>" +
            "<b>Reg name : </b>" + Layer.feature.properties.E1903_map_rgname + "<br>" +
            "<b>Reg name (fr) : </b>" + Layer.feature.properties.E1903_map_rgname_lab_fr + "<br>" +
            "<b>Reg name (en) : </b>" + Layer.feature.properties.E1903_map_rgname_lab_en + "<br>" +
            "<b>Reg scale : </b>" + Layer.feature.properties.E1903_map_rgname_scale + "<br>" +
            "<b>Reg parent : </b>" + Layer.feature.properties.E1903_map_rgname_parent1_en + "<br>" +
            "<br>" +
            "<b><i>Respondent : </b></i>" + Layer.feature.properties.X0001_met_respID_aut + "<br>" +
            "<b>Sex : </b>" + Layer.feature.properties.sex + "<br>" +
            "<b>Country : </b>" + Layer.feature.properties.country + "<br>" +
            "<b>Fields of study : </b>" + Layer.feature.properties.field + "<br>" +
            "<b>Level of study : </b>" + Layer.feature.properties.levels + "<br>" +
            "<b>Nationality : </b>" + Layer.feature.properties.iddoc + "<br>" +
            "<b>Opinion of EU :</b>" + Layer.feature.properties.opiEU 
        })
        layer.on({
          mouseover: highlightFeature,
          mouseout: resetHighlight,
        });
      }
      
      // MAP
      
      const container = yield htl.html`<div style="height: 50vh; width: 50vh">`;
      const map = L.map(container);
      const layer = L.geoJSON(macro_resp_W1B_2, {
        onEachFeature: onEachFeature,
        style: {
          fillOpacity: 0.2,
          color: "#FFBC50",
          weight: 1.5}
      }).addTo(map);
      
      // fit map to geom bounds  
      map.fitBounds(layer.getBounds(), {maxZoom: 9});
      
      // Tile Layer  
      L.tileLayer("https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
                  {attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
                    subdomains: "abcd",
                    maxZoom: 10
                  }).addTo(map);
    }
  
  // ---------------------------------------------------------------------------
    //                        TABLE
  // ---------------------------------------------------------------------------
    
    
    // ---------------------------------------------------------------------------
    //                        DATA
  // ---------------------------------------------------------------------------
    
  macroreg_students_W1B_2 = FileAttachment("../data/W1B_2.GeoJSON").json()
  
  macroreg_W1B_2 = geo_W1B_2.simplify(macroreg_students_W1B_2, {k:0.2})
  
  macroreg_sorted_W1B_2 = geo_W1B_2.featurecollection(macroreg_W1B_2.features.sort((a, b) => d3.descending(a.properties.area_3857, b.properties.area_3857)))
  
  macroreg_filtered_W1B_2 = {
    let filtered =  select_W1B_2 == "All" ? macroreg_sorted_W1B_2 : geo_W1B_2.filter(macroreg_sorted_W1B_2, (d) => d.country == select_W1B_2)
    return geo_W1B_2.rewind(filtered)
  }
  
  macro_resp_W1B_2 = geo_W1B_2.filter(macroreg_filtered_W1B_2, d => d?.X0001_met_respID_aut == respListUnique_W1B_2[nextResp_W1B_2])
  
  respList_W1B_2 = macroreg_filtered_W1B_2.features.map(d => d.properties.X0001_met_respID_aut)
  
  respListUnique_W1B_2 = [...new Set(respList_W1B_2.filter(value => value !== undefined))]
  
  // ---------------------------------------------------------------------------
    //                        LIBS
  // ---------------------------------------------------------------------------
    
    geo_W1B_2 = require("geotoolbox@2.0.3")