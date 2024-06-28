// FUNCTION SET ----------------------------------------------------

function set(input, value) {
  input.value = value;
  input.dispatchEvent(new Event("input", {bubbles: true}));
}


// WIDGETS ----------------------------------------------------

//   {{< include ../scripts/W1A_map_stu_reg.js >}}
//   {{< include ../scripts/W1B_map_stu_explo.js >}}



{{< include ../scripts/W1C_map_stu_ant.js >}}
{{< include ../scripts/W1D_map_stu_carib.js >}}

{{< include ../scripts/W2A_wcd_stu_eur.js >}}
{{< include ../scripts/W2B_wcd_med_reg.js >}}
{{< include ../scripts/W2C_wcd_stu_reg.js >}}

//   {{< include ../scripts/W3A_afc_stu_eur.R >}}
//   {{< include ../scripts/W3B_afc_med_red.R >}}

//  {{< include ../scripts/W3A_afc_stu_eur.js >}}
//  {{< include ../scripts/W3B_afc_med_reg.js >}}

{{< include ../scripts/W4A_map_stu_live.js >}}
{{< include ../scripts/W4B_map_stu_wish.js >}}
{{< include ../scripts/W4C_map_med_state.js >}}
{{< include ../scripts/W2D_map_tweet.js >}}

{{< include ../scripts/W5A_txt_interviews.js >}}

{{< include ../scripts/W7A_bar_med_reg_asso.js >}}
{{< include ../scripts/W7B_bar_stu_cadrag.js >}}
{{< include ../scripts/W7C_bar_stu_wish.js >}}