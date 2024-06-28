library(scatterD3)

W3B_data <- read.csv("../data/W3B_data.csv")

scatterD3(data = W3B_data, x = coo1, y = coo2, lab = label,
          col_var = type,
          xlab = "coo1", ylab = "coo2", col_lab = "inr",
          symbol_lab = "Manual transmission", labels_positions = "auto", 
          width = "90%", menu = FALSE)

